import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:traveltime/constants/Theme.dart';
import 'package:traveltime/screens/map/overview_provider.dart';
import 'package:traveltime/store/db.dart';
import 'package:traveltime/store/models/point.dart';
import 'package:traveltime/widgets/map/popover_provider.dart';

class MarkerListItemController extends ConsumerWidget {
  final int id;

  const MarkerListItemController({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final point = ref.watch(pointProvider(id));
    return point.when(
      data: (data) {
        return data == null
            ? Container()
            : MarkerListItem(
                point: data,
                onTap: (point) {
                  ref
                      .read(overviewProvider.notifier)
                      .show(OverviewData(point: point));
                  ref.read(popoverProvider.notifier).hide();
                });
      },
      error: (error, stackTrace) {
        return Container();
      },
      loading: () {
        return Container();
      },
    );
  }
}

class MarkerListItem extends StatelessWidget {
  const MarkerListItem({super.key, required this.point, this.onTap});

  final Point point;
  final void Function(Point point)? onTap;

  @override
  Widget build(BuildContext context) {
    const height = 60.0;
    return Padding(
      padding:
          const EdgeInsets.symmetric(vertical: UIGap.g2, horizontal: UIGap.g3),
      child: ElevatedButton(
        onPressed: () {
          onTap?.call(point);
        },
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
            if (point.logoImg != null)
              Container(
                width: height,
                height: height,
                decoration: BoxDecoration(
                  borderRadius:
                      const BorderRadius.all(Radius.circular(UIGap.g3)),
                  image: DecorationImage(
                    image: CachedNetworkImageProvider(point.logoImg!),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            Flexible(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: UIGap.g1, horizontal: UIGap.g2),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(point.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodyMedium),
                      Text(point.intro ?? point.description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodySmall),
                    ]),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
