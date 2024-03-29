import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:traveltime/screens/map/widgets/overview/overview_navbar.dart';
import 'package:traveltime/screens/map/widgets/overview/overview_route_content.dart';
import 'package:traveltime/store/db.dart';
import 'package:traveltime/widgets/not_found.dart';

class OverviewRoute extends ConsumerWidget {
  const OverviewRoute({super.key, this.sc, required this.id});

  final int id;
  final ScrollController? sc;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final point = ref.watch(routeProvider(id));
    return point.when(
      data: (data) {
        return data == null
            ? const Stack(children: [NotFound(), OverviewNavbar()])
            : Stack(
                children: [
                  OverviewRouteContent(route: data, sc: sc),
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
