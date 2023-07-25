import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:traveltime/constants/theme.dart';
import 'package:traveltime/constants/routes.dart';
import 'package:traveltime/providers/overview/overview.dart';
import 'package:traveltime/store/db.dart';
import 'package:traveltime/store/models/point.dart';
import 'package:traveltime/store/models/event.dart';
import 'package:traveltime/screens/map/widgets/popover/marker_list_item.dart';

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
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(
                horizontal: UIGap.g2, vertical: UIGap.g2),
            physics: const NeverScrollableScrollPhysics(),
            separatorBuilder: (context, index) =>
                const SizedBox(height: UIGap.g2),
            itemBuilder: (_, idx) {
              return MarkerListItem(
                point: points[idx],
                onTap: (point) {
                  ref
                      .read(overviewProvider.notifier)
                      .show(OverviewData(object: point));
                  context.pushNamed(Routes.map);
                },
              );
            },
            itemCount: points.length,
          ),
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
