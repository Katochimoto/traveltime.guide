import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:traveltime/constants/Theme.dart';
import 'package:traveltime/constants/routes.dart';
import 'package:traveltime/providers/point_overview.dart';
import 'package:traveltime/store/db.dart';
import 'package:traveltime/store/models/point.dart';
import 'package:traveltime/store/models/event.dart';
import 'package:traveltime/widgets/map/marker_list_item.dart';

class EventPointsList extends ConsumerWidget {
  final List<Point> points;

  const EventPointsList({super.key, required this.points});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.location,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: UIGap.g1),
        Card(
          child: Column(children: [
            for (Point point in points) ...[
              MarkerListItem(
                point: point,
                onTap: (point) {
                  ref
                      .read(pointOverviewProvider.notifier)
                      .show(OverviewData(point: point));
                  context.pushNamed(Routes.map);
                },
              )
            ]
          ]),
        )
      ],
    );
  }
}

class EventPoints extends ConsumerWidget {
  final Event event;

  const EventPoints({super.key, required this.event});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final points = ref.watch(eventPointsProvider(event));

    return points.when(
      data: (data) {
        return data.isEmpty
            ? const SizedBox.shrink()
            : EventPointsList(points: data);
      },
      error: (error, stackTrace) {
        return const SizedBox.shrink();
      },
      loading: () {
        return const SizedBox.shrink();
      },
    );
  }
}
