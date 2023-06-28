import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:traveltime/constants/Theme.dart';
import 'package:traveltime/providers/overview/overview.dart';
import 'package:traveltime/store/db.dart';
import 'package:traveltime/store/models.dart' as models;
import 'package:traveltime/widgets/map/popover_not_found.dart';
import 'package:traveltime/widgets/map/popover_progress.dart';
import 'package:traveltime/providers/marker_popover.dart';

class PopoverRouteController extends ConsumerWidget {
  final double width;
  final double height;
  final PopoverData popover;

  const PopoverRouteController({
    super.key,
    required this.width,
    required this.height,
    required this.popover,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final route = ref.watch(routeProvider(popover.routeIds![0]!));
    return route.when(
      data: (data) {
        return data == null
            ? PopoverNotFound(width: width, height: height)
            : PopoverRoute(
                width: width,
                height: height,
                route: data,
                onTap: (point) {
                  // ref
                  //     .read(overviewProvider.notifier)
                  //     .show(OverviewData(point: point));
                  ref.read(popoverProvider.notifier).hide();
                },
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

class PopoverRoute extends StatelessWidget {
  const PopoverRoute({
    super.key,
    required this.width,
    required this.height,
    required this.route,
    this.onTap,
  });

  final double width;
  final double height;
  final models.Route route;
  final void Function(models.Route route)? onTap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        onTap?.call(route);
      },
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
            if (route.logoImg != null)
              Container(
                  height: 120,
                  width: 120,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(UIGap.g3),
                        bottomLeft: Radius.circular(UIGap.g3)),
                    image: DecorationImage(
                      image: NetworkImage(route.logoImg!),
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
                            Text(route.title,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.bodyMedium),
                            Text(route.intro ?? route.description,
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
