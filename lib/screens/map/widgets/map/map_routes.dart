import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:traveltime/providers/marker_popover.dart';
import 'package:traveltime/screens/map/consts.dart';
import 'package:traveltime/store/db.dart';
import 'package:traveltime/widgets/map/tappable_polyline.dart';

class MapRoutes extends ConsumerWidget {
  const MapRoutes({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final routes = ref.watch(routesProvider).valueOrNull ?? [];
    final routeWaypoints = ref.watch(routeWaypointsProvider).valueOrNull ?? [];
    final routeLegs = ref.watch(routeLegsProvider).valueOrNull ?? [];
    print(routes);
    print(routeWaypoints);

    return TappablePolylineLayer(
      polylineCulling: true,
      pointerDistanceTolerance: 5,
      polylines: [
        if (routeLegs.isNotEmpty)
          RouteLegPolyline(
            leg: routeLegs[0],
            points: routeLegs[0].points!,
            color: defaultRouteColor,
            strokeWidth: 4.0,
          ),
      ],
      onTap: (polylines, bounds) {
        ref.read(popoverProvider.notifier).show(PopoverData(
              bounds: bounds,
              type: PopoverType.route,
              routeIds:
                  polylines.map((e) => e.leg.isarRoute).toList(growable: false),
            ));
      },
      onMiss: (bounds) {
        print('No polyline was tapped at position');
      },
    );
  }
}
