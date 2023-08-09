import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:traveltime/providers/app_auth.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:traveltime/providers/events_calendar.dart';
import 'package:traveltime/store/models/event.dart';

class EventsCalendar extends ConsumerWidget {
  const EventsCalendar({super.key, required this.events});

  final List<Event> events;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final primaryColor = Theme.of(context).primaryColor;
    final state = ref.watch(eventsCalendarProvider);
    final user = ref.watch(appAuthProvider).value!;

    return TableCalendar<Event>(
      firstDay: state.firstDay,
      lastDay: state.lastDay,
      focusedDay: state.focusedDay,
      calendarFormat: CalendarFormat.month,
      locale: user.locale.languageCode,
      calendarStyle: CalendarStyle(
        todayDecoration: BoxDecoration(
          color: primaryColor.withOpacity(0.5),
          shape: BoxShape.circle,
        ),
        selectedDecoration: BoxDecoration(
          color: primaryColor,
          shape: BoxShape.circle,
        ),
        holidayTextStyle: TextStyle(color: primaryColor),
        holidayDecoration: BoxDecoration(
          border: Border.fromBorderSide(
            BorderSide(color: primaryColor, width: 1.4),
          ),
          shape: BoxShape.circle,
        ),
      ),
      headerStyle: const HeaderStyle(
        titleCentered: true,
        formatButtonVisible: false,
      ),
      holidayPredicate: (day) {
        // Every 20th day of the month will be treated as a holiday
        return day.day == 20;
      },
      selectedDayPredicate: (day) {
        return isSameDay(state.selectedDay, day);
      },
      eventLoader: (day) {
        return events
            .where((event) => event.hasOnDay(day))
            .toList(growable: false);
      },
      calendarBuilders: CalendarBuilders(
        // selectedBuilder: (context, day, focusedDay) {},
        markerBuilder: (context, day, events) {
          return null;
        },
        singleMarkerBuilder: (context, day, event) {
          return const Icon(
            Icons.circle,
            size: 10,
          );
        },
        // dowBuilder: (context, day) {
        //   if (day.weekday == DateTime.sunday) {
        //     final text = 'asdasd';

        //     return Center(
        //       child: Text(
        //         text,
        //         style: TextStyle(color: Colors.red),
        //       ),
        //     );
        //   }
        // },
      ),
      onDaySelected: (selectedDay, focusedDay) {
        if (!isSameDay(state.selectedDay, selectedDay)) {
          ref.read(eventsCalendarProvider.notifier).selectDay(selectedDay);
        }
      },
      // onFormatChanged: (format) {
      //   if (_calendarFormat != format) {
      //     setState(() {
      //       _calendarFormat = format;
      //     });
      //   }
      // },
      // onPageChanged: (focusedDay) {
      //   _focusedDay = focusedDay;
      // },
    );
  }
}
