import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong2/latlong.dart';
import 'package:traveltime/widgets/map/popover_cluster.dart';
import 'package:traveltime/widgets/map/popover_marker.dart';
import 'package:traveltime/widgets/map/triangle_painter.dart';

class Position {
  Bounds? bounds;
  LatLng? point;

  Position({this.bounds, this.point});

  factory Position.empty() {
    return Position();
  }
}

class PopoverPosition extends Notifier<Position> {
  @override
  Position build() {
    return Position.empty();
  }

  void updatePosition(Position data) {
    state = data;
  }

  void hide() {
    if (state.bounds != null) {
      state = Position.empty();
    }
  }
}

final popoverPositionProvider = NotifierProvider<PopoverPosition, Position>(() {
  return PopoverPosition();
});

class Popover extends ConsumerWidget {
  const Popover({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final position = ref.watch(popoverPositionProvider);
    if (position.bounds == null) {
      return Container();
    }

    const width = 300.0;
    const height = 170.0;

    final x =
        position.bounds!.topLeft.x.toDouble() + position.bounds!.size.x * 0.5;
    final y = position.bounds!.topLeft.y.toDouble();

    return Stack(
      children: <Widget>[
        Positioned(
          left: x - 15 * 0.5,
          top: y - 15,
          child: CustomPaint(
            size: const Size(15.0, 8.0),
            painter: TrianglePainter(
                isDown: true, color: Theme.of(context).cardColor),
          ),
        ),
        Positioned(
          top: y - height - 15,
          left: x - width * 0.5,
          child: const PopoverCluster(width: width, height: height),
        ),
      ],
    );
  }
}
