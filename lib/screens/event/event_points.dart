import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:traveltime/constants/routes.dart';
import 'package:traveltime/providers/overview/overview.dart';
import 'package:traveltime/screens/event/event_points_list.dart';
import 'package:traveltime/store/db.dart';
import 'package:traveltime/store/models.dart' as models;
import 'package:traveltime/utils/extra_nav_params.dart';

class EventPoints extends ConsumerWidget {
  const EventPoints({
    super.key,
    required this.event,
    required this.date,
  });

  final models.Event event;
  final DateTime? date;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(eventPointsProvider(event)).when(
          data: (data) => data.isEmpty
              ? const SizedBox.shrink()
              : EventPointsList(
                  points: data,
                  onTap: (point) {
                    ref
                        .read(overviewProvider.notifier)
                        .show(OverviewData(object: point));
                    context.goNamed(
                      Routes.map,
                      extra: ExtraNavParams(onBack: (context, ref) {
                        context.goNamed(
                          Routes.event,
                          pathParameters: {'id': event.isarId.toString()},
                          queryParameters: {'date': date?.toIso8601String()},
                        );
                      }),
                    );
                  }),
          error: (error, stackTrace) => const SizedBox.shrink(),
          loading: () => const SizedBox.shrink(),
        );
  }
}
