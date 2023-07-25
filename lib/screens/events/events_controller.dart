import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:traveltime/constants/_theme.dart';
import 'package:traveltime/screens/events/events_calendar.dart';
import 'package:traveltime/screens/events/events_list.dart';
import 'package:traveltime/store/db.dart';
import 'package:traveltime/widgets/not_found.dart';

class EventsController extends ConsumerWidget {
  const EventsController({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final events = ref.watch(eventsProvider);
    return events.when(
      data: (data) {
        return data.isEmpty
            ? const NotFound()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  EventsCalendar(events: data),
                  const SizedBox(height: UIGap.g2),
                  Expanded(child: EventsList(events: data)),
                ],
              );
      },
      error: (error, stackTrace) {
        return const NotFound();
      },
      loading: () {
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
