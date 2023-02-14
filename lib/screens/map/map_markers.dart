import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' as ll;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:traveltime/store/db.dart';
import 'package:traveltime/widgets/map/draw_cluster.dart';
import 'package:traveltime/widgets/map/draw_text.dart';
import 'package:traveltime/widgets/map/fast_markers.dart';
import 'package:traveltime/widgets/map/popover.dart';

const markerSize = 25.0;
const clusterSize = 40.0;

final markerFillPaint = Paint()
  ..color = Colors.white
  ..style = PaintingStyle.fill;

final markerStrokePaint = Paint()
  ..color = Colors.teal
  ..style = PaintingStyle.stroke
  ..strokeWidth = 2
  ..strokeCap = StrokeCap.round;

final arrowPaint = Paint()
  ..strokeWidth = 2.0
  ..color = Colors.teal
  ..style = PaintingStyle.fill;

class MapMarkers extends ConsumerWidget {
  const MapMarkers({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final points = ref.watch(pointsProvider).value ?? [];
    final markers = points.map((point) {
      return FastMarker(
        point: ll.LatLng(point.lat, point.lng),
        width: markerSize,
        height: markerSize,
        anchorPos: AnchorPos.align(AnchorAlign.bottom),
        onDraw: _drawMarker,
        onTap: (bounds, point) {
          ref
              .read(popoverPositionProvider.notifier)
              .updatePosition(Position(bounds: bounds, point: point));
        },
      );
    });

    return FastMarkersLayer(
      markers: markers.toList(growable: false),
      drawCluster: _drawCluster,
      clusterWidth: clusterSize,
      clusterHeight: clusterSize,
    );
  }

  void _drawMarker(Canvas canvas, Offset offset) {
    const contentSize = markerSize * 0.8;
    const arrowHeight = markerSize * 0.3;
    const arrowWidth = markerSize * 0.4;
    final contentCenter =
        offset + const Offset(markerSize * 0.5, contentSize * 0.5);
    final arrowStart = offset + const Offset(markerSize * 0.5, markerSize);

    final path = Path()
      ..moveTo(arrowStart.dx, arrowStart.dy)
      ..lineTo(arrowStart.dx - arrowWidth * 0.5, arrowStart.dy - arrowHeight)
      ..lineTo(arrowStart.dx + arrowWidth * 0.5, arrowStart.dy - arrowHeight);

    canvas.drawPath(path, arrowPaint);

    canvas.drawCircle(
      contentCenter,
      contentSize * 0.5,
      markerFillPaint,
    );

    canvas.drawCircle(
      contentCenter,
      contentSize * 0.5,
      markerStrokePaint,
    );

    DrawText.draw(
      canvas: canvas,
      text: '🎡',
      offset: offset + const Offset(markerSize * 0.5 - contentSize * 0.5, 0),
      size: contentSize,
      // paragraphWidth: markerSize * 0.5,
      fontSize: contentSize * 0.5,
    );
  }

  void _drawCluster(Canvas canvas, Offset offset) {
    final center = offset +
        const Offset(
          clusterSize / 2,
          clusterSize / 2,
        );

    canvas.drawCircle(
      center,
      clusterSize / 2,
      markerFillPaint,
    );

    DrawCluster.draw(
      canvas,
      center: center,
      radius: clusterSize / 2,
      sources: [10, 20, 16],
      colors: [Colors.blue, Colors.yellow, Colors.green],
      paintWidth: 5,
      startAngle: 0.0,
    );

    DrawText.draw(
      canvas: canvas,
      text: '10',
      offset: offset,
      size: clusterSize,
    );
  }
}
