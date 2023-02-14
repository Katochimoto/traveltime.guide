import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong2/latlong.dart';
import 'package:traveltime/widgets/map/popover_cluster.dart';
import 'package:traveltime/widgets/map/popover_marker.dart';
import 'package:traveltime/widgets/map/triangle_painter.dart';

enum PopoverType {
  marker,
  cluster,
}

class PopoverData {
  final PopoverType? type;
  final Bounds? bounds;
  final LatLng? point;

  const PopoverData({this.bounds, this.point, this.type = PopoverType.marker});

  factory PopoverData.empty() {
    return const PopoverData();
  }
}

class PopoverDataController extends Notifier<PopoverData> {
  @override
  PopoverData build() {
    return PopoverData.empty();
  }

  void show(PopoverData data) {
    state = data;
  }

  void hide() {
    if (state.bounds != null) {
      state = PopoverData.empty();
    }
  }
}

final popoverProvider =
    NotifierProvider<PopoverDataController, PopoverData>(() {
  return PopoverDataController();
});

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
                isDown: true, color: Theme.of(context).cardColor),
          ),
        ),
        Positioned(
          top: y - height - 15,
          left: x - width * 0.5,
          child: popover.type == PopoverType.cluster
              ? PopoverCluster(width: width, height: height)
              : PopoverMarker(width: width, height: height),
        ),
      ],
    );
  }
}
