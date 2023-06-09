import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
      pointerDistanceTolerance: 20,
      polylines: [
        if (routeLegs.isNotEmpty)
          TaggedPolyline(
            tag: 'My Polyline',
            points: routeLegs[0].points!,
            color: defaultRouteColor,
            strokeWidth: 4.0,
          ),
      ],
      onTap: (polylines, offset) => print(
          'Tapped: ${polylines.map((polyline) => polyline.tag).join(',')}'),
      onMiss: (offset) {
        print('No polyline was tapped at position');
      },
    );
  }
}
