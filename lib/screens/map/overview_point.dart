import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:traveltime/screens/map/overview_point_content.dart';
import 'package:traveltime/screens/map/overview_navbar.dart';
import 'package:traveltime/store/db.dart';
import 'package:traveltime/widgets/not_found.dart';

class OverviewPoint extends ConsumerWidget {
  const OverviewPoint({super.key, this.sc, required this.id});

  final int id;
  final ScrollController? sc;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final point = ref.watch(pointProvider(id));
    return point.when(
      data: (data) {
        return data == null
            ? const Stack(children: [NotFound(), OverviewNavbar()])
            : Stack(
                children: [
                  OverviewPointContent(point: data, sc: sc),
                  const OverviewNavbar(),
                ],
              );
      },
      error: (error, stackTrace) {
        return const Stack(children: [NotFound(), OverviewNavbar()]);
      },
      loading: () {
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
