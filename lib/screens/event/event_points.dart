import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:traveltime/screens/event/event_points_list.dart';
import 'package:traveltime/store/db.dart';
import 'package:traveltime/store/models.dart' as models;

class EventPoints extends ConsumerWidget {
  const EventPoints({super.key, required this.event});

  final models.Event event;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(eventPointsProvider(event)).when(
          data: (data) => data.isEmpty
              ? const SizedBox.shrink()
              : EventPointsList(points: data),
          error: (error, stackTrace) => const SizedBox.shrink(),
          loading: () => const SizedBox.shrink(),
        );
  }
}
