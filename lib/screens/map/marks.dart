import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:traveltime/constants/Theme.dart';

class Marks extends ConsumerWidget {
  const Marks({super.key, this.sc, this.padding});

  final ScrollController? sc;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.builder(
      controller: sc,
      physics: const BouncingScrollPhysics(),
      padding: padding,
      itemBuilder: (_, idx) {
        const height = 55.0;
        return Padding(
          padding: const EdgeInsets.symmetric(
              vertical: UIGap.g2, horizontal: UIGap.g3),
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                padding: const EdgeInsets.all(0),
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(UIGap.g3)))),
            child: SizedBox(
              height: height,
              child: Row(children: [
                Container(
                  width: height,
                  height: height,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(UIGap.g3)),
                    image: DecorationImage(
                      image: CachedNetworkImageProvider(
                          'https://via.placeholder.com/200'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Flexible(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.only(left: UIGap.g2),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('asd',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.bodyMedium),
                            Text(
                                'asdasdasdasdasdaksjdklajskldjklasdklaasdasdasdasdasdaksjdklajskldjklasdklaskldjasldskldjasldasdasdasdasdasdaksjdklajskldjklasdklaasdasdasdasdasdaksjdklajskldjklasdklaskldjasldskldjasld',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.bodySmall),
                          ]),
                    )),
              ]),
            ),
          ),
        );
      },
      itemCount: 100,
    );
  }
}
