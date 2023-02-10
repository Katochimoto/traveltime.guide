import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong2/latlong.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:traveltime/constants/Theme.dart';
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

    const width = 300.0;
    const height = 120.0;
    final offset = mapState.getOffsetFromOrigin(position.point!);

    return Stack(
      children: <Widget>[
        Positioned(
          left: offset.dx - 7.5,
          top: offset.dy - position.bounds!.size.x * 0.5 - 12,
          child: CustomPaint(
            size: const Size(15.0, 8.0),
            painter: TrianglePainter(
                isDown: true, color: Theme.of(context).cardColor),
          ),
        ),
        Positioned(
          top: offset.dy - height - position.bounds!.size.x * 0.5 - 12,
          left: offset.dx - width * 0.5,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: Theme.of(context).cardColor,
                shadowColor: Colors.transparent,
                padding: const EdgeInsets.all(0),
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(UIGap.g3)))),
            child: SizedBox(
              width: width,
              height: height,
              child: Row(
                children: [
                  Container(
                      height: 120,
                      width: 120,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(UIGap.g3),
                              bottomLeft: Radius.circular(UIGap.g3)),
                          image: DecorationImage(
                            image: CachedNetworkImageProvider(
                                'https://via.placeholder.com/200'),
                            fit: BoxFit.cover,
                          ))),
                  Flexible(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: UIGap.g2, horizontal: UIGap.g3),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('asd',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium),
                                  Text(
                                      'asdasdasdasdasdaksjdklajskldjklasdklaasdasdasdasdasdaksjdklajskldjklasdklaskldjasldskldjasldasdasdasdasdasdaksjdklajskldjklasdklaasdasdasdasdasdaksjdklajskldjklasdklaskldjasldskldjasld',
                                      maxLines: 4,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall),
                                ]),
                          ],
                        ),
                      ))
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
