import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timelines/timelines.dart';
import 'package:traveltime/constants/theme.dart';
import 'package:traveltime/store/db.dart';
// import 'package:traveltime/screens/map/overview_bookmark.dart';
// import 'package:traveltime/screens/map/overview_openapp.dart';
import 'package:traveltime/store/models.dart' as models;
import 'package:traveltime/screens/map/widgets/popover/marker_list_item.dart';
import 'package:traveltime/widgets/overview/overview_content.dart';
import 'package:traveltime/widgets/overview/overview_web.dart';

class _RouteWaypointPoint extends ConsumerWidget {
  const _RouteWaypointPoint({required this.id});

  final int id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final point = ref.watch(pointProvider(id)).value;
    if (point == null) {
      return const SizedBox.shrink();
    }
    return MarkerListItem(point: point);
  }
}

class _RouteWaypoint extends ConsumerWidget {
  const _RouteWaypoint({required this.waypoint});

  final models.RouteWaypoint waypoint;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (waypoint.point != null)
            _RouteWaypointPoint(id: waypoint.point!)
          else if (waypoint.title != null)
            Text(waypoint.title!)
          else
            Text(
                '${waypoint.lat!.toStringAsFixed(6)}, ${waypoint.lng!.toStringAsFixed(6)}'),
          if (waypoint.intro != null && waypoint.point != null)
            const SizedBox(height: UIGap.g1),
          if (waypoint.intro != null)
            Text(waypoint.intro!, style: Theme.of(context).textTheme.bodySmall),
        ],
      ),
    );
  }
}

class _RouteWaypoints extends ConsumerWidget {
  const _RouteWaypoints({required this.route});

  final models.Route route;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timelineColor =
        Theme.of(context).colorScheme.secondary.withOpacity(0.5);

    return ref.watch(routeWaypointsByRouteProvider(route.isarId)).when(
          data: (data) => FixedTimeline.tileBuilder(
            theme: TimelineThemeData(
              nodePosition: 0,
              nodeItemOverlap: true,
              connectorTheme: ConnectorThemeData(
                thickness: 2.0,
                color: timelineColor,
              ),
              indicatorTheme: IndicatorThemeData(
                size: 20.0,
                color: timelineColor,
              ),
            ),
            builder: TimelineTileBuilder.connected(
              contentsAlign: ContentsAlign.basic,
              contentsBuilder: (context, index) =>
                  _RouteWaypoint(waypoint: data[index]),
              itemCount: data.length,
              nodePositionBuilder: (context, index) => 0,
              connectorBuilder: (_, index, connectorType) => SolidLineConnector(
                indent: connectorType == ConnectorType.start ? 0 : 0.0,
                endIndent: connectorType == ConnectorType.end ? 0 : 0.0,
              ),
              indicatorBuilder: (_, index) => Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  DotIndicator(
                    color: Colors.white,
                    size: 20.0,
                    border: Border.all(color: timelineColor, width: 2),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text((index + 1).toString(),
                          style: const TextStyle(fontSize: 11)),
                    ),
                  ),
                ],
              ),
            ),
          ),
          error: (error, stackTrace) => const SizedBox.shrink(),
          loading: () => const SizedBox.shrink(),
        );
  }
}

class OverviewRouteContent extends StatelessWidget {
  const OverviewRouteContent({super.key, this.sc, required this.route});

  final ScrollController? sc;
  final models.Route route;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(UIGap.g3),
            topRight: Radius.circular(UIGap.g3)),
      ),
      child: OverviewContent(
        sc: sc,
        coverImage: route.coverImg,
        title: route.title,
        content: route.description,
        actions: [
          if (route.web != null) OverviewWeb(url: route.web!),
        ],
        extra: [
          const SizedBox(height: UIGap.g2),
          _RouteWaypoints(route: route),
        ],
      ),
    );
  }
}
