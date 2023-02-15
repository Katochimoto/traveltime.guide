import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:traveltime/constants/Theme.dart';
import 'package:traveltime/widgets/map/popover_provider.dart';

class PopoverMarker extends ConsumerWidget {
  final double width;
  final double height;
  final PopoverData popover;

  const PopoverMarker({
    super.key,
    required this.width,
    required this.height,
    required this.popover,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
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
                                style: Theme.of(context).textTheme.bodyMedium),
                            Text(
                                'asdasdasdasdasdaksjdklajskldjklasdklaasdasdasdasdasdaksjdklajskldjklasdklaskldjasldskldjasldasdasdasdasdasdaksjdklajskldjklasdklaasdasdasdasdasdaksjdklajskldjklasdklaskldjasldskldjasld',
                                maxLines: 4,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.bodySmall),
                          ]),
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
