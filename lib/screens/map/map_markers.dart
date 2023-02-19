import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong2/latlong.dart' as ll;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:traveltime/screens/map/consts.dart';
import 'package:traveltime/store/db.dart';
import 'package:traveltime/store/models/point.dart';
import 'package:traveltime/widgets/map/draw_cluster.dart';
import 'package:traveltime/widgets/map/draw_text.dart';
import 'package:traveltime/widgets/map/fast_markers.dart';
import 'package:traveltime/providers/marker_popover.dart';

class MapMarkers extends ConsumerWidget {
  const MapMarkers({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final points = ref.watch(pointsProvider).value ?? [];
    final markers = points.map((point) {
      return FastMarker(
        id: point.isarId,
        category: point.category,
        point: ll.LatLng(point.lat, point.lng),
        width: markerSize,
        height: markerSize,
        anchorPos: AnchorPos.align(AnchorAlign.bottom),
        onDraw: _drawMarker,
        onTap: (bounds, marker) {
          ref.read(popoverProvider.notifier).show(PopoverData(
                bounds: bounds,
                pointIds: [marker.id],
              ));
        },
      );
    });

    return FastMarkersLayer(
      markers: markers.toList(growable: false),
      clusterTap: (bounds, cluster) {
        final pointIds =
            cluster.markers!.map((marker) => marker.id).toList(growable: false);
        ref.read(popoverProvider.notifier).show(PopoverData(
              bounds: bounds,
              type: PopoverType.cluster,
              pointIds: pointIds,
            ));
      },
      clusterDraw: _drawCluster,
      clusterWidth: clusterSize,
      clusterHeight: clusterSize,
    );
  }

  void _drawMarker(Canvas canvas, Offset offset, FastMarker marker) {
    const contentSize = markerSize * 0.75;
    const arrowHeight = markerSize * 0.3;
    const arrowWidth = markerSize * 0.4;
    final contentCenter =
        offset + const Offset(markerSize * 0.5, contentSize * 0.5);
    final arrowStart = offset + const Offset(markerSize * 0.5, markerSize);

    final path = Path()
      ..moveTo(arrowStart.dx, arrowStart.dy)
      ..lineTo(arrowStart.dx - arrowWidth * 0.5, arrowStart.dy - arrowHeight)
      ..lineTo(arrowStart.dx + arrowWidth * 0.5, arrowStart.dy - arrowHeight);

    canvas.drawCircle(
      contentCenter,
      contentSize * 0.5,
      markerShadowPaint[marker.category] ?? defaultMarkerShadowPaint,
    );

    canvas.drawPath(
        path, markerShadowPaint[marker.category] ?? defaultMarkerShadowPaint);

    canvas.drawPath(path, arrowPaint);

    canvas.drawCircle(
      contentCenter,
      contentSize * 0.5,
      markerFillPaint[marker.category] ?? defaultMarkerFillPaint,
    );

    canvas.drawCircle(
      contentCenter,
      contentSize * 0.5,
      markerStrokePaint,
    );

    final icon = markerIcons[marker.category];
    if (icon != null) {
      DrawText.draw(
        canvas: canvas,
        text: String.fromCharCode(icon.codePoint),
        offset: offset,
        width: markerSize,
        height: contentSize,
        fontFamily: icon.fontFamily,
        color: Colors.white,
        fontSize: (contentSize * 0.7).ceil().toDouble(),
      );
    }
  }

  void _drawCluster(Canvas canvas, Offset offset, FastCluster cluster) {
    final center = offset +
        const Offset(
          clusterSize / 2,
          clusterSize / 2,
        );

    var sources = <PointCategory, double>{};
    var colors = <PointCategory, Color>{};
    for (var i = 0; i < cluster.markers!.length; i++) {
      final marker = cluster.markers![i];
      if (sources.containsKey(marker.category)) {
        sources[marker.category] = sources[marker.category]! + 1;
      } else {
        sources[marker.category] = 1;
        colors[marker.category] =
            markerColors[marker.category] ?? defaultMarkerColor;
      }
    }

    canvas.drawCircle(
      center,
      clusterSize / 2,
      clusterFillPaint,
    );

    DrawCluster.draw(
      canvas,
      center: center,
      radius: clusterSize / 2,
      sources: sources.values.toList(growable: false),
      colors: colors.values.toList(growable: false),
      paintWidth: 4,
      startAngle: 0.0,
    );

    DrawText.draw(
      canvas: canvas,
      text: cluster.markers!.length.toString(),
      offset: offset,
      width: clusterSize,
      height: clusterSize,
    );
  }
}
