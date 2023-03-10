import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:traveltime/providers/app_auth.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:traveltime/store/models/event.dart';

final kToday = DateTime.now();
final kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
final kLastDay = DateTime(kToday.year, kToday.month + 3, kToday.day);

class EventsCalendar extends ConsumerWidget {
  final List<Event> events;

  const EventsCalendar({super.key, required this.events});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final primaryColor = Theme.of(context).primaryColor;

    return TableCalendar<Event>(
      firstDay: kFirstDay,
      lastDay: kLastDay,
      focusedDay: DateTime.now(),
      calendarFormat: CalendarFormat.month,
      locale: AppLocale.en.name,
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
        return false;
        // isSameDay(kToday, day);
      },
      eventLoader: (day) {
        return events
            .where(
                (event) => event.getDayInstances(date: day).take(1).isNotEmpty)
            .toList(growable: false);
      },
      calendarBuilders: CalendarBuilders(
        // selectedBuilder: (context, day, focusedDay) {},
        markerBuilder: (context, day, events) {},
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
      // onDaySelected: (selectedDay, focusedDay) {
      //   if (!isSameDay(_selectedDay, selectedDay)) {
      //     setState(() {
      //       _selectedDay = selectedDay;
      //       _focusedDay = focusedDay;
      //     });
      //   }
      // },
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
