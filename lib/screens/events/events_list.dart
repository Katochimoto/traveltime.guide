import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:traveltime/constants/routes.dart';
import 'package:traveltime/constants/theme/custom_colors.dart';
import 'package:traveltime/providers/events_calendar.dart';
import 'package:traveltime/widgets/card/card_horizontal.dart';
import 'package:traveltime/store/models.dart' as models;

class EventsList extends ConsumerWidget {
  const EventsList({super.key, required this.eventsByDay});

  final List<models.Event> Function(DateTime day) eventsByDay;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).extension<CustomColors>();
    final state = ref.watch(eventsCalendarProvider);
    final list = eventsByDay(state.selectedDay);

    if (list.isEmpty) {
      return const SizedBox.shrink();
    }

    return ListView.builder(
      itemCount: list.length,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (_, idx) {
        final event = list[idx];
        return CardHorizontal(
            color: colors!.eventCategoryColor[event.category],
            title: event.title,
            details: event.intro ?? event.description,
            img: event.logoImg,
            tap: () {
              context.pushNamed(
                Routes.event,
                pathParameters: {'id': event.isarId.toString()},
                queryParameters: {'date': state.selectedDay.toIso8601String()},
              );
            });
      },
    );
  }
}
