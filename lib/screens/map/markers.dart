import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:traveltime/store/db.dart';
import 'package:traveltime/widgets/map/marker_list_item.dart';

class Markers extends ConsumerWidget {
  const Markers({super.key, this.sc});

  final ScrollController? sc;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final points = ref.watch(pointsProvider).value ?? [];
    return ListView.builder(
      controller: sc,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (_, idx) {
        return MarkerListItem(point: points[idx]);
      },
      itemCount: points.length,
    );
  }
}
