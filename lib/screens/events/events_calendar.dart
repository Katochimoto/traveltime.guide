import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:traveltime/constants/theme/custom_colors.dart';
import 'package:traveltime/providers/app_auth.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:traveltime/providers/events_calendar.dart';
import 'package:traveltime/store/models.dart' as models;

class EventsCalendar extends ConsumerWidget {
  const EventsCalendar({super.key, required this.eventsByDay});

  final List<models.Event> Function(DateTime day) eventsByDay;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).extension<CustomColors>();
    final primaryColor = Theme.of(context).primaryColor;
    final state = ref.watch(eventsCalendarProvider);
    final user = ref.watch(appAuthProvider).value!;

    return TableCalendar<models.Event>(
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
      holidayPredicate: (day) =>
          eventsByDay(day).any((event) => event.isHoliday),
      selectedDayPredicate: (day) {
        return isSameDay(state.selectedDay, day);
      },
      eventLoader: (day) => eventsByDay(day),
      calendarBuilders: CalendarBuilders(
        // selectedBuilder: (context, day, focusedDay) {},
        markerBuilder: (context, day, events) {
          return null;
        },
        singleMarkerBuilder: (context, day, event) {
          return Icon(
            Icons.circle,
            size: 10,
            color: colors!.eventCategoryDeepColor[event.category],
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
