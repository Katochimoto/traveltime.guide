import 'package:flutter_riverpod/flutter_riverpod.dart';

class EventsCalendarState {
  final DateTime today;
  final DateTime firstDay;
  final DateTime lastDay;
  final DateTime selectedDay;
  final DateTime focusedDay;

  const EventsCalendarState({
    required this.today,
    required this.firstDay,
    required this.lastDay,
    required this.selectedDay,
    required this.focusedDay,
  });

  factory EventsCalendarState.def() {
    final today = DateTime.now().toUtc();
    return EventsCalendarState(
      today: today,
      firstDay: DateTime.utc(today.year, today.month - 3, today.day),
      lastDay: DateTime.utc(today.year, today.month + 3, today.day),
      selectedDay: today,
      focusedDay: today,
    );
  }

  EventsCalendarState selectDay(DateTime day) {
    return EventsCalendarState(
      today: today,
      firstDay: firstDay,
      lastDay: lastDay,
      selectedDay: day,
      focusedDay: day,
    );
  }
}

class EventsCalendarController
    extends AutoDisposeNotifier<EventsCalendarState> {
  @override
  EventsCalendarState build() {
    return EventsCalendarState.def();
  }

  void selectDay(DateTime day) {
    state = state.selectDay(day);
  }
}

final eventsCalendarProvider =
    NotifierProvider.autoDispose<EventsCalendarController, EventsCalendarState>(
        () {
  return EventsCalendarController();
});
