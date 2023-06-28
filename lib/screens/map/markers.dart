import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:traveltime/providers/point_overview.dart';
import 'package:traveltime/store/db.dart';
import 'package:traveltime/widgets/map/marker_list_item.dart';
import 'package:traveltime/store/models.dart' as models;

class Markers extends ConsumerWidget {
  const Markers({super.key, this.sc});

  final ScrollController? sc;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final objects = ref.watch(mapObjectsProvider).value ?? [];
    return ListView.builder(
      controller: sc,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (_, idx) {
        if (objects[idx] is models.Point) {
          return MarkerListItem(
            point: objects[idx] as models.Point,
            onTap: (point) {
              ref.read(pointOverviewProvider.notifier).show(OverviewData(
                    point: point,
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
