import 'package:flutter/material.dart';
import 'package:traveltime/providers/app_auth.dart';
import 'package:table_calendar/table_calendar.dart';

final kToday = DateTime.now();
final kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
final kLastDay = DateTime(kToday.year, kToday.month + 3, kToday.day);

class Event {
  final String title;

  const Event(this.title);

  @override
  String toString() => title;
}

class EventsCalendar extends StatelessWidget {
  const EventsCalendar({super.key});

  @override
  Widget build(BuildContext context) {
    return TableCalendar<Event>(
      firstDay: kFirstDay,
      lastDay: kLastDay,
      focusedDay: DateTime.now(),
      calendarFormat: CalendarFormat.month,
      locale: AppLocale.en.name,
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
        if (day.weekday == DateTime.monday) {
          return [
            Event('Cyclic event1'),
            Event('Cyclic event2'),
            Event('Cyclic event3'),
            Event('Cyclic event4'),
          ];
        }

        return [Event('Cyclic event1')];
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
