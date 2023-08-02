import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:traveltime/constants/theme.dart';
import 'package:traveltime/screens/events/events_calendar.dart';
import 'package:traveltime/screens/events/events_list.dart';
import 'package:traveltime/store/db.dart';
import 'package:traveltime/widgets/not_found.dart';

class EventsView extends ConsumerWidget {
  const EventsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(eventsProvider).when(
          data: (data) => data.isEmpty
              ? const NotFound()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    EventsCalendar(events: data),
                    const SizedBox(height: UIGap.g2),
                    Expanded(child: EventsList(events: data)),
                  ],
                ),
          error: (error, stackTrace) => const NotFound(),
          loading: () => const Center(child: CircularProgressIndicator()),
        );
  }
}
