import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timelines/timelines.dart';
import 'package:traveltime/constants/Theme.dart';
import 'package:traveltime/store/db.dart';
// import 'package:traveltime/screens/map/overview_bookmark.dart';
// import 'package:traveltime/screens/map/overview_openapp.dart';
import 'package:traveltime/store/models.dart' as models;

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
          Text(waypoint.title ?? waypoint.id),
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
    final waypoints =
        ref.watch(routeWaypointsByRouteProvider(route.id)).valueOrNull ?? [];
    return FixedTimeline.tileBuilder(
      theme: TimelineThemeData(
        nodePosition: 0,
        connectorTheme: ConnectorThemeData(
          thickness: 1.5,
          color: Theme.of(context).disabledColor,
        ),
        indicatorTheme: IndicatorThemeData(
          size: 25.0,
          color: Theme.of(context).disabledColor,
        ),
      ),
      builder: TimelineTileBuilder.connected(
        contentsAlign: ContentsAlign.basic,
        contentsBuilder: (context, index) =>
            _RouteWaypoint(waypoint: waypoints[index]),
        itemCount: waypoints.length,
        nodePositionBuilder: (context, index) => 0,
        connectorBuilder: (_, index, connectorType) =>
            const SolidLineConnector(),
        indicatorBuilder: (_, index) => Stack(
          alignment: AlignmentDirectional.center,
          children: [
            const OutlinedDotIndicator(borderWidth: 1.5),
            Text((index + 1).toString()),
          ],
        ),
      ),
    );
  }
}

class OverviewRouteContent extends StatelessWidget {
  const OverviewRouteContent({super.key, this.sc, required this.route});

  final ScrollController? sc;
  final models.Route route;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Flexible(
          flex: 2,
          child: Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(UIGap.g3),
                      topRight: Radius.circular(UIGap.g3)),
                  image: route.coverImg != null
                      ? DecorationImage(
                          image: NetworkImage(route.coverImg!),
                          fit: BoxFit.cover,
                        )
                      : const DecorationImage(
                          image: AssetImage('assets/imgs/drawer_bg.jpg'),
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              Container(
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(UIGap.g3),
                          topRight: Radius.circular(UIGap.g3)),
                      color: Colors.black45)),
              Padding(
                padding: const EdgeInsets.only(
                    bottom: UIGap.g2, left: UIGap.g3, right: UIGap.g3),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      route.title,
                      style: Theme.of(context)
                          .textTheme
                          .merge(Typography.whiteCupertino)
                          .headlineMedium,
                    ),
                    const SizedBox(height: UIGap.g2),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: UIGap.g3),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          // OverviewOpenapp(route: route),
                          // OverviewBookmark(route: route),
                          // OverviewVisited(route: route),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Flexible(
          flex: 3,
          child: Padding(
            padding: const EdgeInsets.all(UIGap.g3),
            child: ListView(
              controller: sc,
              physics: const BouncingScrollPhysics(),
              children: [
                MarkdownBody(data: route.description),
                _RouteWaypoints(route: route),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
