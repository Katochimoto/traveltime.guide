import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:traveltime/screens/map/widgets/overview/point_events_list.dart';
import 'package:traveltime/store/db.dart';
import 'package:traveltime/store/models.dart' as models;

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
                child: PointEventsList(events: data),
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
