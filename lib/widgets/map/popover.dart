import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong2/latlong.dart';
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
    if (state.point != null) {
      state = Position.empty();
    }
  }
}

final popoverPositionProvider = NotifierProvider<PopoverPosition, Position>(() {
  return PopoverPosition();
});

class MapPopover extends ConsumerWidget {
  const MapPopover({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mapState = FlutterMapState.maybeOf(context)!;
    final position = ref.watch(popoverPositionProvider);
    if (position.point == null) {
      return Container();
    }

    const width = 220.0;
    const height = 100.0;
    final offset = mapState.getOffsetFromOrigin(position.point!);

    return Stack(
      children: <Widget>[
        Positioned(
          top: offset.dy - height - position.bounds!.size.x * 0.5 - 8,
          left: offset.dx - width * 0.5,
          child: SizedBox(
            width: width,
            height: height,
            child: Card(
              color: Theme.of(context).cardColor,
              shadowColor: Colors.transparent,
              elevation: 0,
              child: const Text('asdasd'),
            ),
          ),
        ),
        Positioned(
          left: offset.dx - 7.5,
          top: offset.dy - position.bounds!.size.x * 0.5 - 12,
          child: CustomPaint(
            size: const Size(15.0, 8.0),
            painter: TrianglePainter(
                isDown: true, color: Theme.of(context).cardColor),
          ),
        ),
      ],
    );
  }
}
