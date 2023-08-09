import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:traveltime/constants/routes.dart';
import 'package:traveltime/providers/overview/overview.dart';
import 'package:traveltime/screens/map/widgets/overview/point_events_list.dart';
import 'package:traveltime/store/db.dart';
import 'package:traveltime/store/models.dart' as models;
import 'package:traveltime/utils/extra_nav_params.dart';

class PointEvents extends ConsumerWidget {
  const PointEvents({
    super.key,
    required this.point,
    this.padding,
  });

  final models.Point point;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final events = ref.watch(pointEventsProvider(point));

    return events.when(
      data: (data) {
        return data.isEmpty
            ? const SizedBox.shrink()
            : Container(
                padding: padding,
                child: PointEventsList(
                    events: data,
                    onTap: (event) {
                      context.goNamed(
                        Routes.event,
                        pathParameters: {'id': event.isarId.toString()},
                        extra: ExtraNavParams(onBack: (context, ref) {
                          ref
                              .read(overviewProvider.notifier)
                              .show(OverviewData(object: point));
                          context.goNamed(Routes.map);
                        }),
                      );
                    }),
              );
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
