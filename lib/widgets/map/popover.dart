import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:traveltime/widgets/map/popover_cluster.dart';
import 'package:traveltime/widgets/map/popover_marker.dart';
import 'package:traveltime/widgets/map/popover_provider.dart';
import 'package:traveltime/widgets/map/triangle_painter.dart';

class Popover extends ConsumerWidget {
  const Popover({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final popover = ref.watch(popoverProvider);
    if (popover.bounds == null) {
      return Container();
    }

    const width = 300.0;
    final height = popover.type == PopoverType.cluster ? 170.0 : 120.0;

    final x =
        popover.bounds!.topLeft.x.toDouble() + popover.bounds!.size.x * 0.5;
    final y = popover.bounds!.topLeft.y.toDouble();

    return Stack(
      children: <Widget>[
        Positioned(
          left: x - 15 * 0.5,
          top: y - 15,
          child: CustomPaint(
            size: const Size(15.0, 8.0),
            painter: TrianglePainter(
              isDown: true,
              color: Theme.of(context).cardColor,
            ),
          ),
        ),
        Positioned(
          top: y - height - 15,
          left: x - width * 0.5,
          child: popover.type == PopoverType.cluster
              ? PopoverCluster(
                  width: width,
                  height: height,
                  popover: popover,
                )
              : PopoverMarker(width: width, height: height),
        ),
      ],
    );
  }
}
