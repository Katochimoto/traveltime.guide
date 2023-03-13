import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:traveltime/constants/routes.dart';
import 'package:traveltime/providers/events_calendar.dart';
import 'package:traveltime/widgets/card/card_horizontal.dart';
import 'package:traveltime/store/models/event.dart';

class EventsList extends ConsumerWidget {
  final List<Event> events;

  const EventsList({super.key, required this.events});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(eventsCalendarProvider);
    final list = events
        .where((event) => event.hasOnDay(state.selectedDay))
        .toList(growable: false);

    if (list.isEmpty) {
      return const SizedBox.shrink();
    }

    return ListView.builder(
      itemCount: list.length,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (_, idx) {
        final event = list[idx];
        return CardHorizontal(
            title: event.title,
            details: event.intro,
            img: event.logoImg,
            tap: () {
              context.pushNamed(Routes.event,
                  params: {'id': event.isarId.toString()});
            });
      },
    );
  }
}
