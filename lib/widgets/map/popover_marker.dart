import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:traveltime/constants/Theme.dart';
import 'package:traveltime/store/db.dart';
import 'package:traveltime/store/models/point.dart';
import 'package:traveltime/widgets/map/popover_not_found.dart';
import 'package:traveltime/widgets/map/popover_progress.dart';
import 'package:traveltime/widgets/map/popover_provider.dart';

class PopoverMarkerController extends ConsumerWidget {
  final double width;
  final double height;
  final PopoverData popover;

  const PopoverMarkerController({
    super.key,
    required this.width,
    required this.height,
    required this.popover,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final point = ref.watch(pointProvider(popover.pointIds![0]!));
    return point.when(
      data: (data) {
        return data == null
            ? PopoverNotFound(width: width, height: height)
            : PopoverMarker(
                width: width,
                height: height,
                point: data,
              );
      },
      error: (error, stackTrace) {
        return PopoverNotFound(width: width, height: height);
      },
      loading: () {
        return PopoverProgress(width: width, height: height);
      },
    );
  }
}

class PopoverMarker extends ConsumerWidget {
  final double width;
  final double height;
  final Point point;

  const PopoverMarker({
    super.key,
    required this.width,
    required this.height,
    required this.point,
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
            borderRadius: BorderRadius.all(Radius.circular(UIGap.g3))),
      ),
      child: SizedBox(
        width: width,
        height: height,
        child: Row(
          children: [
            if (point.logoImg != null)
              Container(
                  height: 120,
                  width: 120,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(UIGap.g3),
                        bottomLeft: Radius.circular(UIGap.g3)),
                    image: DecorationImage(
                      image: CachedNetworkImageProvider(point.logoImg!),
                      fit: BoxFit.cover,
                    ),
                  )),
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
                            Text(point.title,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.bodyMedium),
                            Text(point.intro ?? point.description,
                                maxLines: 3,
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
