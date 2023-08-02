import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:traveltime/widgets/map/fast_cluster.dart';
import 'package:traveltime/widgets/map/fast_marker.dart';

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
  var _pxCache = <CustomPoint<double>>[];

  // Calling this every time markerOpts change should guarantee proper length
  List<CustomPoint<double>> generatePxCache() => List.generate(
        markers.length,
        (i) => mapState.project(markers[i].point),
      );

  @override
  void paint(Canvas canvas, Size size) {
    final sameZoom = mapState.zoom == _lastZoom;
    markersBoundsCache.clear();
    clustersBoundsCache.clear();

    final markersBounds = <FastMarker, Bounds<double>>{};
    for (var i = 0; i < markers.length; i++) {
      final marker = markers[i];
      final pxPoint = sameZoom ? _pxCache[i] : mapState.project(marker.point);
      if (!sameZoom) {
        _pxCache[i] = pxPoint;
      }

      final topLeft = CustomPoint<double>(
        pxPoint.x - marker.anchor.left,
        pxPoint.y - marker.anchor.top,
      );
      final bottomRight = CustomPoint<double>(
        topLeft.x + marker.width,
        topLeft.y + marker.height,
      );
      markersBounds[marker] = Bounds<double>(topLeft, bottomRight);
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
            Bounds<double>(posTopLeft, posBottomRight),
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
            Bounds<double>(posTopLeft, posBottomRight),
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
      if (marker.key.contains(CustomPoint<double>(pos!.dx, pos.dy))) {
        marker.value.onTap?.call(marker.key, marker.value);
        return false;
      }
    }

    final clusters = clustersBoundsCache.reversed.toList();
    for (var i = 0; i < clusters.length; i++) {
      var cluster = clusters[i];
      if (cluster.key.contains(CustomPoint<double>(pos!.dx, pos.dy))) {
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
    required List<CustomPoint<double>> pxPoints,
    double radius = 60.0,
  }) {
    final radiusSq = radius * radius;
    final clusters = <FastCluster>[];
    final clustersBounds = <FastCluster, Bounds<double>>{};

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
        clustersBounds[nextCluster] = Bounds<double>(point, point);
      }

      final clusterBounds = clustersBounds[nextCluster]!;
      nextCluster.markers!.add(marker);
      nextCluster.bounds = clusterBounds.extend(point);
    }

    for (var i = 0; i < clusters.length; i++) {
      final cluster = clusters[i];
      final center = cluster.bounds!.center;
      cluster.bounds = Bounds<double>(
        CustomPoint<double>(
          center.x - clusterWidth! / 2,
          center.y - clusterHeight! / 2,
        ),
        CustomPoint<double>(
          center.x + clusterWidth! / 2,
          center.y + clusterHeight! / 2,
        ),
      );
    }

    return clusters;
  }
}
