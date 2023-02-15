import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:traveltime/store/models/point.dart';

class TapPosition {
  Offset? offset;

  TapPosition({this.offset});

  factory TapPosition.empty() {
    return TapPosition();
  }
}

class MapTapPosition extends Notifier<TapPosition> {
  @override
  TapPosition build() {
    return TapPosition.empty();
  }

  void updatePosition(TapPosition data) {
    state = data;
  }

  void hide() {
    if (state.offset != null) {
      state = TapPosition.empty();
    }
  }

  void tap(Offset offset) {
    if (state.offset != offset) {
      state = TapPosition(offset: offset);
    }
  }
}

final mapTapPositionProvider =
    NotifierProvider<MapTapPosition, TapPosition>(() {
  return MapTapPosition();
});

class FastMarker {
  final int id;
  final PointCategory category;
  final LatLng point;
  final double width;
  final double height;
  final Anchor anchor;
  final Function(Canvas canvas, Offset offset, FastMarker marker) onDraw;
  final Function(Bounds bounds, FastMarker marker)? onTap;

  FastMarker({
    required this.id,
    required this.category,
    required this.point,
    this.width = 30.0,
    this.height = 30.0,
    required this.onDraw,
    this.onTap,
    AnchorPos? anchorPos,
  }) : anchor = Anchor.forPos(anchorPos, width, height);
}

class FastCluster {
  LatLng? point;
  Bounds? bounds;
  List<FastMarker>? markers;

  FastCluster({
    this.point,
    this.bounds,
    this.markers,
  });
}

class FastMarkersLayer extends StatelessWidget {
  const FastMarkersLayer({
    super.key,
    required this.markers,
    this.clusterTap,
    this.clusterDraw,
    this.clusterWidth,
    this.clusterHeight,
  });

  final List<FastMarker> markers;
  final void Function(Bounds bounds, FastCluster cluster)? clusterTap;
  final void Function(Canvas canvas, Offset offset, FastCluster cluster)?
      clusterDraw;
  final double? clusterWidth;
  final double? clusterHeight;

  @override
  Widget build(BuildContext context) {
    final mapState = FlutterMapState.maybeOf(context)!;
    return FastMarkersLayerController(
      markers: markers,
      mapState: mapState,
      clusterTap: clusterTap,
      clusterDraw: clusterDraw,
      clusterWidth: clusterWidth,
      clusterHeight: clusterHeight,
    );
  }
}

class FastMarkersLayerController extends ConsumerStatefulWidget {
  const FastMarkersLayerController({
    super.key,
    required this.markers,
    required this.mapState,
    this.clusterTap,
    this.clusterDraw,
    this.clusterWidth,
    this.clusterHeight,
  });

  final List<FastMarker> markers;
  final FlutterMapState mapState;
  final void Function(Bounds bounds, FastCluster cluster)? clusterTap;
  final void Function(Canvas canvas, Offset offset, FastCluster cluster)?
      clusterDraw;
  final double? clusterWidth;
  final double? clusterHeight;

  @override
  ConsumerState<FastMarkersLayerController> createState() =>
      FastMarkersLayerState();
}

class FastMarkersLayerState extends ConsumerState<FastMarkersLayerController> {
  late FastMarkersPainter painter;

  @override
  void initState() {
    super.initState();
    painter = FastMarkersPainter(
      markers: widget.markers,
      mapState: widget.mapState,
      clusterTap: widget.clusterTap,
      clusterDraw: widget.clusterDraw,
      clusterWidth: widget.clusterWidth,
      clusterHeight: widget.clusterHeight,
    );
  }

  @override
  void didUpdateWidget(covariant FastMarkersLayerController oldWidget) {
    super.didUpdateWidget(oldWidget);
    painter = FastMarkersPainter(
      markers: widget.markers,
      mapState: widget.mapState,
      clusterTap: widget.clusterTap,
      clusterDraw: widget.clusterDraw,
      clusterWidth: widget.clusterWidth,
      clusterHeight: widget.clusterHeight,
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(mapTapPositionProvider, (previous, next) {
      painter.onTap(next.offset);
    });

    return CustomPaint(
      painter: painter,
      willChange: true,
    );
  }
}

class FastMarkersPainter extends CustomPainter {
  FastMarkersPainter({
    required this.markers,
    required this.mapState,
    this.clusterTap,
    this.clusterDraw,
    this.clusterWidth,
    this.clusterHeight,
  }) {
    _lastZoom = mapState.zoom;
    _pxCache = generatePxCache();
  }

  FlutterMapState mapState;
  List<FastMarker> markers = [];
  void Function(Bounds bounds, FastCluster cluster)? clusterTap;
  void Function(Canvas canvas, Offset offset, FastCluster cluster)? clusterDraw;
  double? clusterWidth;
  double? clusterHeight;

  List<MapEntry<Bounds, FastMarker>> markersBoundsCache = [];
  List<MapEntry<Bounds, FastCluster>> clustersBoundsCache = [];
  var _lastZoom = -1.0;

  /// List containing cached pixel positions of markers
  /// Should be discarded when zoom changes
  // Has a fixed length of markerOpts.markers.length - better performance:
  // https://stackoverflow.com/questions/15943890/is-there-a-performance-benefit-in-using-fixed-length-lists-in-dart
  var _pxCache = <CustomPoint>[];

  // Calling this every time markerOpts change should guarantee proper length
  List<CustomPoint> generatePxCache() => List.generate(
        markers.length,
        (i) => mapState.project(markers[i].point),
      );

  @override
  void paint(Canvas canvas, Size size) {
    final sameZoom = mapState.zoom == _lastZoom;
    markersBoundsCache.clear();
    clustersBoundsCache.clear();

    final markersBounds = <FastMarker, Bounds>{};
    for (var i = 0; i < markers.length; i++) {
      final marker = markers[i];
      final pxPoint = sameZoom ? _pxCache[i] : mapState.project(marker.point);
      if (!sameZoom) {
        _pxCache[i] = pxPoint;
      }

      final topLeft = CustomPoint(
        pxPoint.x - marker.anchor.left,
        pxPoint.y - marker.anchor.top,
      );
      final bottomRight = CustomPoint(
        topLeft.x + marker.width,
        topLeft.y + marker.height,
      );
      markersBounds[marker] = Bounds(topLeft, bottomRight);
    }

    final clusters = _clusterMarkers(
      markers: markers,
      pxPoints: _pxCache,
    );

    final clusterDraws =
        clusters.where((item) => item.markers!.length > 1).toList();

    final drawMarkers = clusters
        .where((item) => item.markers!.length == 1)
        .map((item) => item.markers![0])
        .toList();

    for (var i = 0; i < clusterDraws.length; i++) {
      final cluster = clusterDraws[i];
      if (mapState.pixelBounds.containsPartialBounds(cluster.bounds!)) {
        final bounds = cluster.bounds!;
        final posTopLeft = bounds.topLeft - mapState.pixelOrigin;
        final posBottomRight = bounds.bottomRight - mapState.pixelOrigin;
        final offset = Offset(posTopLeft.x.toDouble(), posTopLeft.y.toDouble());

        clusterDraw!(canvas, offset, cluster);

        clustersBoundsCache.add(
          MapEntry(
            Bounds(posTopLeft, posBottomRight),
            cluster,
          ),
        );
      }
    }

    for (var i = 0; i < drawMarkers.length; i++) {
      final marker = drawMarkers[i];
      final bounds = markersBounds[marker]!;
      if (mapState.pixelBounds.containsPartialBounds(bounds)) {
        final posTopLeft = bounds.topLeft - mapState.pixelOrigin;
        final posBottomRight = bounds.bottomRight - mapState.pixelOrigin;

        marker.onDraw(
          canvas,
          Offset(posTopLeft.x.toDouble(), posTopLeft.y.toDouble()),
          marker,
        );

        markersBoundsCache.add(
          MapEntry(
            Bounds(posTopLeft, posBottomRight),
            marker,
          ),
        );
      }
    }

    _lastZoom = mapState.zoom;
  }

  bool onTap(Offset? pos) {
    final markers = markersBoundsCache.reversed.toList();
    for (var i = 0; i < markers.length; i++) {
      var marker = markers[i];
      if (marker.key.contains(CustomPoint(pos!.dx, pos.dy))) {
        marker.value.onTap?.call(marker.key, marker.value);
        return false;
      }
    }

    final clusters = clustersBoundsCache.reversed.toList();
    for (var i = 0; i < clusters.length; i++) {
      var cluster = clusters[i];
      if (cluster.key.contains(CustomPoint(pos!.dx, pos.dy))) {
        clusterTap?.call(cluster.key, cluster.value);
        return false;
      }
    }

    return true;
  }

  @override
  bool shouldRepaint(covariant FastMarkersPainter oldDelegate) {
    return true;
  }

  List<FastCluster> _clusterMarkers({
    required List<FastMarker> markers,
    required List<CustomPoint<num>> pxPoints,
    double radius = 60.0,
  }) {
    final radiusSq = radius * radius;
    final clusters = <FastCluster>[];
    final clustersBounds = <FastCluster, Bounds>{};

    for (var i = 0; i < markers.length; i++) {
      final marker = markers[i];
      final point = pxPoints[i];
      double minRadiusSq = radiusSq;
      FastCluster? nextCluster;

      for (final cluster in clusters) {
        final clusterBounds = clustersBounds[cluster];
        final diff = point - clusterBounds!.center;

        if (diff.x.abs() > radius || diff.x.abs() > radius) {
          continue;
        }

        final rSq = diff.x * diff.x + diff.x * diff.x;
        if (rSq > minRadiusSq) {
          continue;
        }
        minRadiusSq = rSq.toDouble();
        nextCluster = cluster;
      }

      if (nextCluster == null) {
        nextCluster = FastCluster(markers: []);
        clusters.add(nextCluster);
        clustersBounds[nextCluster] = Bounds(point, point);
      }

      final clusterBounds = clustersBounds[nextCluster]!;
      nextCluster.markers!.add(marker);
      nextCluster.bounds = clusterBounds.extend(point);
    }

    for (var i = 0; i < clusters.length; i++) {
      final cluster = clusters[i];
      final center = cluster.bounds!.center;
      cluster.bounds = Bounds(
        CustomPoint(
          center.x - clusterWidth! / 2,
          center.y - clusterHeight! / 2,
        ),
        CustomPoint(
          center.x + clusterWidth! / 2,
          center.y + clusterHeight! / 2,
        ),
      );
    }

    return clusters;
  }
}
