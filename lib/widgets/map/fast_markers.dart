import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong2/latlong.dart';

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
  FastMarkersLayer({super.key, required this.markers, required this.tapStream});

  List<FastMarker> markers = [];

  Stream<Offset?> tapStream;

  @override
  Widget build(BuildContext context) {
    final mapState = FlutterMapState.maybeOf(context)!;
    return FastMarkersLayerController(
        markers: markers, tapStream: tapStream, mapState: mapState);
  }
}

class FastMarkersLayerController extends StatefulWidget {
  FastMarkersLayerController(
      {super.key,
      required this.markers,
      required this.tapStream,
      required this.mapState});

  List<FastMarker> markers = [];
  FlutterMapState mapState;
  Stream<Offset?> tapStream;

  @override
  FastMarkersLayerState createState() => FastMarkersLayerState();
}

class FastMarkersLayerState extends State<FastMarkersLayerController> {
  late FastMarkersPainter painter;
  late StreamSubscription<Offset?> subscription;

  @override
  void initState() {
    super.initState();
    painter = FastMarkersPainter(
      markers: widget.markers,
      mapState: widget.mapState,
    );

    subscription = widget.tapStream.listen((event) {
      painter.onTap(event);
    }, cancelOnError: false);
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
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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

      var topLeft = CustomPoint(
        pxPoint.x - marker.anchor.left,
        pxPoint.y - marker.anchor.top,
      );
      var bottomRight = CustomPoint(
        topLeft.x + marker.width,
        topLeft.y + marker.height,
      );

      if (!mapState.pixelBounds
          .containsPartialBounds(Bounds(topLeft, bottomRight))) {
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
