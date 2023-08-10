import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:traveltime/constants/theme.dart';
import 'package:traveltime/screens/events/events_calendar.dart';
import 'package:traveltime/screens/events/events_list.dart';
import 'package:traveltime/store/db.dart';
import 'package:traveltime/widgets/not_found.dart';
import 'package:traveltime/store/models.dart' as models;

class EventsView extends ConsumerWidget {
  const EventsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(eventsProvider).when(
          data: (data) {
            if (data.isEmpty) {
              return const NotFound();
            }

            final cache = <DateTime, List<models.Event>>{};
            eventsByDay(DateTime day) => cache[day] ??= data
                .where((event) => event.hasOnDay(day))
                .toList(growable: false);

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                EventsCalendar(eventsByDay: eventsByDay),
                const SizedBox(height: UIGap.g2),
                Expanded(child: EventsList(eventsByDay: eventsByDay)),
              ],
            );
          },
          error: (error, stackTrace) => const NotFound(),
          loading: () => const Center(child: CircularProgressIndicator()),
        );
  }
}
