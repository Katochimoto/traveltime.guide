import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:traveltime/constants/theme.dart';
import 'package:traveltime/providers/overview/overview.dart';
import 'package:traveltime/store/db.dart';
import 'package:traveltime/screens/map/widgets/popover/marker_list_item.dart';
import 'package:traveltime/store/models.dart' as models;
import 'package:traveltime/screens/map/widgets/popover/route_list_item.dart';

class Markers extends ConsumerWidget {
  const Markers({super.key, this.sc});

  final ScrollController? sc;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final objects = ref.watch(mapObjectsProvider).value ?? [];
    return ListView.separated(
      controller: sc,
      physics: const BouncingScrollPhysics(),
      padding:
          const EdgeInsets.symmetric(horizontal: UIGap.g3, vertical: UIGap.g2),
      separatorBuilder: (context, index) => const SizedBox(height: UIGap.g2),
      itemBuilder: (_, idx) {
        if (objects[idx] is models.Point) {
          return MarkerListItem(
            point: objects[idx] as models.Point,
            onTap: (point) {
              ref.read(overviewProvider.notifier).show(OverviewData(
                    object: point,
                    animation: true,
                  ));
            },
          );
        } else if (objects[idx] is models.Route) {
          return RouteListItem(
            route: objects[idx] as models.Route,
            onTap: (route) {
              ref.read(overviewProvider.notifier).show(OverviewData(
                    object: route,
                    animation: true,
                  ));
            },
          );
        }

        return const SizedBox.shrink();
      },
      itemCount: objects.length,
    );
  }
}
