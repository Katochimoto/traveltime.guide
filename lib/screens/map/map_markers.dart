import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong2/latlong.dart' as ll;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:traveltime/store/db.dart';
import 'package:traveltime/store/models/point.dart';
import 'package:traveltime/widgets/map/draw_cluster.dart';
import 'package:traveltime/widgets/map/draw_text.dart';
import 'package:traveltime/widgets/map/fast_markers.dart';
import 'package:traveltime/widgets/map/popover_provider.dart';

const markerSize = 30.0;
const clusterSize = 40.0;

const defaultMarkerColor = Colors.teal;

final markerColors = {
  PointCategory.entertainment: Colors.teal,
  PointCategory.events: Colors.deepPurple,
  PointCategory.attraction: Colors.green,
  PointCategory.nightMarket: Colors.lightBlue,
  PointCategory.hypermarket: Colors.lightBlue,
  PointCategory.beach: Colors.yellow,
  PointCategory.restaurant: Colors.orange,
  PointCategory.cafe: Colors.orange,
  PointCategory.marina: Colors.cyan,
  PointCategory.police: Colors.blueGrey,
  PointCategory.gasStation: Colors.brown,
  PointCategory.carRental: Colors.brown,
  PointCategory.hotel: Colors.pink,
};

final markerIcons = {
  PointCategory.entertainment: Icons.sports_score,
  PointCategory.events: Icons.event,
  PointCategory.attraction: Icons.attractions,
  PointCategory.nightMarket: Icons.shopping_cart,
  PointCategory.hypermarket: Icons.shopping_cart,
  PointCategory.beach: Icons.beach_access,
  PointCategory.restaurant: Icons.restaurant,
  PointCategory.cafe: Icons.coffee,
  PointCategory.marina: Icons.directions_ferry,
  PointCategory.police: Icons.local_police,
  PointCategory.gasStation: Icons.gas_meter,
  PointCategory.carRental: Icons.car_rental,
  PointCategory.hotel: Icons.hotel,
};

Paint markerFillPaintFactory(Color color) => Paint()
  ..color = color
  ..style = PaintingStyle.fill;

Paint markerShadowPaintFactory(Color color) => Paint()
  ..color = color
  ..maskFilter = MaskFilter.blur(BlurStyle.normal, sqrt(5));

final defaultMarkerFillPaint = markerFillPaintFactory(defaultMarkerColor);
final defaultMarkerShadowPaint = markerShadowPaintFactory(defaultMarkerColor);

final markerFillPaint = {
  for (var item in PointCategory.values)
    item: markerFillPaintFactory(markerColors[item] ?? defaultMarkerColor),
};

final markerShadowPaint = {
  for (var item in PointCategory.values)
    item: markerShadowPaintFactory(markerColors[item] ?? defaultMarkerColor),
};

final markerStrokePaint = Paint()
  ..color = Colors.white
  ..style = PaintingStyle.stroke
  ..strokeWidth = 2
  ..strokeCap = StrokeCap.round;

final arrowPaint = Paint()
  ..strokeWidth = 2.0
  ..color = Colors.white
  ..style = PaintingStyle.fill;

final clusterFillPaint = Paint()
  ..color = Colors.white
  ..style = PaintingStyle.fill;

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

    // DrawText.draw(
    //   canvas: canvas,
    //   text: String.fromCharCode(Icons.beach_access.codePoint),
    //   offset: offset + const Offset(markerSize * 0.5 - contentSize * 0.5, 0),
    //   size: contentSize,
    //   // paragraphWidth: markerSize * 0.5,
    //   fontSize: contentSize * 0.6,
    //   fontFamily: Icons.beach_access.fontFamily,
    //   color: Colors.white,
    // );

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

    // DrawText.draw(
    //   canvas: canvas,
    //   text: '🎡',
    //   offset: offset + const Offset(markerSize * 0.5 - contentSize * 0.5, 0),
    //   size: contentSize,
    //   // paragraphWidth: markerSize * 0.5,
    //   fontSize: contentSize * 0.5,
    // );
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
