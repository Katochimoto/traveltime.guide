import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';

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
  final LatLng point;
  final double width;
  final double height;
  final Anchor anchor;
  final Function(Canvas canvas, Offset offset) onDraw;
  final Function(Bounds bounds, LatLng point)? onTap;

  FastMarker({
    required this.point,
    this.width = 30.0,
    this.height = 30.0,
    required this.onDraw,
    this.onTap,
    AnchorPos? anchorPos,
  }) : anchor = Anchor.forPos(anchorPos, width, height);
}

class FastMarkersLayer extends StatelessWidget {
  const FastMarkersLayer({super.key, required this.markers});

  final List<FastMarker> markers;

  @override
  Widget build(BuildContext context) {
    final mapState = FlutterMapState.maybeOf(context)!;
    return FastMarkersLayerController(markers: markers, mapState: mapState);
  }
}

class FastMarkersLayerController extends ConsumerStatefulWidget {
  const FastMarkersLayerController(
      {super.key, required this.markers, required this.mapState});

  final List<FastMarker> markers;
  final FlutterMapState mapState;

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
    );
  }

  @override
  void didUpdateWidget(covariant FastMarkersLayerController oldWidget) {
    super.didUpdateWidget(oldWidget);
    painter = FastMarkersPainter(
      markers: widget.markers,
      mapState: widget.mapState,
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
  FastMarkersPainter({required this.markers, required this.mapState}) {
    _lastZoom = mapState.zoom;
    _pxCache = generatePxCache();
  }

  FlutterMapState mapState;
  List<FastMarker> markers = [];
  List<MapEntry<Bounds, FastMarker>> markersBoundsCache = [];
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

    for (var i = 0; i < markers.length; i++) {
      var marker = markers[i];

      // Decide whether to use cached point or calculate it
      var pxPoint = sameZoom ? _pxCache[i] : mapState.project(marker.point);

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
      final markerBounds = Bounds(topLeft, bottomRight);

      if (!mapState.pixelBounds.containsPartialBounds(markerBounds)) {
        continue;
      }

      final pos = topLeft - mapState.pixelOrigin;

      marker.onDraw(
        canvas,
        Offset(pos.x.toDouble(), pos.y.toDouble()),
      );

      markersBoundsCache.add(
        MapEntry(
          Bounds(pos, pos + CustomPoint(marker.width, marker.height)),
          marker,
        ),
      );
    }

    _lastZoom = mapState.zoom;
  }

  bool onTap(Offset? pos) {
    final markers = markersBoundsCache.reversed.toList();
    for (var i = 0; i < markers.length; i++) {
      var marker = markers[i];
      if (marker.key.contains(CustomPoint(pos!.dx, pos.dy))) {
        marker.value.onTap?.call(marker.key, marker.value.point);
        return false;
      }
    }
    return true;
  }

  @override
  bool shouldRepaint(covariant FastMarkersPainter oldDelegate) {
    return true;
  }
}
