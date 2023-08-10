import 'package:duration/duration.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:isar/isar.dart';
import 'package:rrule/rrule.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:traveltime/providers/app_auth.dart';
import 'package:traveltime/utils/date.dart';
import 'package:traveltime/utils/fast_hash.dart';

part 'event.g.dart';

class EventInstance {
  final DateTime start; // included
  final DateTime end; // not included

  EventInstance({
    required this.start,
    required this.end,
  });

  @override
  String toString() {
    final now = DateTime.now().copyWith(isUtc: true);
    String? str;

    if (start.isAtSameMomentAs(end)) {
      if (start.hour == 0 && start.minute == 0) {
        if (start.year == now.year) {
          str = DateFormat.MMMd().format(start);
        } else {
          str = DateFormat.yMMMd().format(start);
        }
      } else {
        if (start.year == now.year) {
          str = DateFormat.MMMd().add_jm().format(start);
        } else {
          str = DateFormat.yMMMd().add_jm().format(start);
        }
      }
    } else {
      if (start.hour == 0 &&
          start.minute == 0 &&
          end.hour == 0 &&
          end.minute == 0) {
        final currentEnd = end.subtract(const Duration(days: 1));
        if (start.isBefore(currentEnd)) {
          if (start.year == currentEnd.year &&
              start.month == currentEnd.month) {
            if (start.year == now.year) {
              str =
                  '${DateFormat.MMMd().format(start)} - ${DateFormat.d().format(currentEnd)}';
            } else {
              str =
                  '${DateFormat.MMMd().format(start)} - ${DateFormat.d().format(currentEnd)}, ${DateFormat.y().format(start)}';
            }
          } else if (start.year == currentEnd.year) {
            if (start.year == now.year) {
              str =
                  '${DateFormat.MMMd().format(start)} - ${DateFormat.MMMd().format(currentEnd)}';
            } else {
              str =
                  '${DateFormat.MMMd().format(start)} - ${DateFormat.MMMd().format(currentEnd)}, ${DateFormat.y().format(start)}';
            }
          } else {
            if (start.year == now.year && currentEnd.year == now.year) {
              str =
                  '${DateFormat.MMMd().format(start)} - ${DateFormat.MMMd().format(currentEnd)}';
            } else {
              str =
                  '${DateFormat.yMMMd().format(start)} - ${DateFormat.yMMMd().format(currentEnd)}';
            }
          }
        } else if (start.isAtSameMomentAs(currentEnd)) {
          if (start.year == now.year) {
            str = DateFormat.MMMd().format(start);
          } else {
            str = DateFormat.yMMMd().format(start);
          }
        }
      } else {
        if (start.year == end.year && start.month == end.month) {
          if (start.year == now.year) {
            str =
                '${DateFormat.MMMd().add_jm().format(start)} - ${DateFormat.d().add_jm().format(end)}';
          } else {
            str =
                '${DateFormat.MMMd().add_jm().format(start)} - ${DateFormat.d().add_jm().format(end)}, ${DateFormat.y().format(start)}';
          }
        } else if (start.year == end.year) {
          if (start.year == now.year) {
            str =
                '${DateFormat.MMMd().add_jm().format(start)} - ${DateFormat.MMMd().add_jm().format(end)}';
          } else {
            str =
                '${DateFormat.MMMd().add_jm().format(start)} - ${DateFormat.MMMd().add_jm().format(end)}, ${DateFormat.y().format(start)}';
          }
        } else {
          if (start.year == now.year && end.year == now.year) {
            str =
                '${DateFormat.MMMd().add_jm().format(start)} - ${DateFormat.MMMd().add_jm().format(end)}';
          } else {
            str =
                '${DateFormat.yMMMd().add_jm().format(start)} - ${DateFormat.yMMMd().add_jm().format(end)}';
          }
        }
      }
    }

    return str ?? 'Invalid date range';
  }
}

enum EventCategory {
  event,
  holiday,
  nationalHoliday,
  regionalHoliday,
  governmentHoliday,
  notPublicHoliday,
}

final eventCategoryColor = <EventCategory, Color?>{
  EventCategory.event: null,
  EventCategory.holiday: Colors.blue[100],
  EventCategory.nationalHoliday: Colors.blue[100],
  EventCategory.regionalHoliday: Colors.green[100],
  EventCategory.governmentHoliday: Colors.red[100],
  EventCategory.notPublicHoliday: Colors.yellow[100],
};

final eventCategoryDeepColor = <EventCategory, Color?>{
  EventCategory.event: null,
  EventCategory.holiday: Colors.blue[500],
  EventCategory.nationalHoliday: Colors.blue[500],
  EventCategory.regionalHoliday: Colors.green[500],
  EventCategory.governmentHoliday: Colors.red[500],
  EventCategory.notPublicHoliday: Colors.yellow[500],
};

@collection
class Event {
  Event({
    required this.id,
    required this.country,
    required this.locale,
    required this.category,
    required this.createdAt,
    required this.updatedAt,
    required this.publishedAt,
    required this.title,
    required this.description,
    required this.points,
    required this.moveMondayIfWeekend,
    this.rrule,
    this.duration,
    this.intro,
    this.logoImg,
    this.coverImg,
    this.dtstart, // included
    this.dtend, // not included
    this.web,
  });

  final String id;

  Id get isarId => fastHash(id);

  final String country;
  final String locale;

  @Enumerated(EnumType.name)
  @Index(type: IndexType.value)
  final EventCategory category;

  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime publishedAt;

  @Index(type: IndexType.value)
  final String title;
  final String description;
  final String? rrule; // https://pub.dev/packages/rrule
  final String? duration; // 2w 5d 23h 59m 59s 999ms 999us OR 245:09:08.007006
  final String? intro;
  final String? logoImg;
  final String? coverImg;

  @Index(type: IndexType.value)
  final List<String> points;

  final DateTime? dtstart;
  final DateTime? dtend;
  final String? web;
  final bool moveMondayIfWeekend;

  @ignore
  Duration? get durationObject =>
      duration?.isNotEmpty == true ? tryParseDurationAny(duration!) : null;

  @ignore
  bool get isHoliday =>
      category == EventCategory.holiday ||
      category == EventCategory.nationalHoliday ||
      category == EventCategory.governmentHoliday;

  bool hasOnDay(DateTime date) {
    final day = normalizeDate(date);
    final startDay = dtstart != null ? normalizeDate(dtstart!) : null;
    final endDay = dtend != null
        ? normalizeDate(dtend!)
        : (durationObject != null && dtstart != null)
            ? normalizeDate(dtstart!.add(durationObject!))
            : null;

    bool exists = false;

    if (rrule != null) {
      if (startDay != null && day.isBefore(startDay)) {
        exists = false;
      } else {
        final RecurrenceRule recurrenceRule = RecurrenceRule.fromString(rrule!);
        exists = _hasOnDayRRule(recurrenceRule, day, startDay);

        if (!exists && moveMondayIfWeekend) {
          exists = _hasIfWeekendRRule(
            recurrenceRule,
            day,
            startDay,
            durationObject,
          );
        }
      }
    } else {
      exists = _hasOnDayRange(day, startDay, endDay);
      if (!exists && moveMondayIfWeekend) {
        exists = _hasIfWeekendRange(
          day,
          startDay,
          endDay,
          durationObject,
        );
      }
    }

    return exists;
  }

  EventInstance? instanceOnDay(DateTime date) {
    final day = normalizeDate(date);

    EventInstance? instance;

    if (rrule != null) {
      final RecurrenceRule recurrenceRule = RecurrenceRule.fromString(rrule!);
      final it = recurrenceRule.getInstances(
        start: day,
        after: day,
        before: day.add(const Duration(days: 1)),
        includeAfter: true,
        includeBefore: false,
      );

      if (it.isNotEmpty) {
        instance = EventInstance(
          start: it.first,
          end: it.first.add(durationObject ?? const Duration()),
        );
      }
    } else {
      instance = EventInstance(
        start: dtstart!,
        end: dtend ?? dtstart!.add(durationObject ?? const Duration()),
      );
    }

    return instance;
  }

  EventInstance? upcomingInstanceFrom(DateTime date) {
    final day = normalizeDate(date).add(const Duration(days: 1));

    EventInstance? instance;

    if (rrule != null) {
      final RecurrenceRule recurrenceRule = RecurrenceRule.fromString(rrule!);
      final it = recurrenceRule.getInstances(
        start: day,
        after: day,
        includeAfter: true,
      );

      if (it.isNotEmpty && hasOnDay(it.first)) {
        instance = EventInstance(
          start: it.first,
          end: it.first.add(durationObject ?? const Duration()),
        );
      }
    }

    return instance;
  }

  /// event actual on "date" or will happen after "date"
  EventInstance? actualInstanceFrom(DateTime date) {
    EventInstance? instance;

    // FIXME add case for rrule
    if (rrule == null) {
      instance = EventInstance(
        start: dtstart!,
        end: dtend ?? dtstart!.add(durationObject ?? const Duration()),
      );
    }

    return instance != null && date.isBefore(instance.end) ? instance : null;
  }

  factory Event.fromJson(data) {
    return Event(
      id: data['id'],
      country: data['country'],
      locale: data['locale'],
      category: EventCategory.values.byName(data['category']),
      createdAt: DateTime.parse(data['createdAt']),
      updatedAt: DateTime.parse(data['updatedAt']),
      publishedAt: DateTime.parse(data['publishedAt']),
      title: data['title'],
      intro: data['intro'],
      description: data['description'],
      rrule: data['rrule'],
      duration: data['duration'],
      logoImg: data['logoImg'],
      coverImg: data['coverImg'],
      points: List<String>.from(data['points'] ?? []),
      dtstart: data['dtstart'] != null ? DateTime.parse(data['dtstart']) : null,
      dtend: data['dtend'] != null ? DateTime.parse(data['dtend']) : null,
      web: data['web'],
      moveMondayIfWeekend: data['moveMondayIfWeekend'] == true,
    );
  }

  static List<Event> fromJsonList(List<dynamic> data) {
    return data
        .map<Event>((item) => Event.fromJson(item))
        .toList(growable: false);
  }
}

bool _hasOnDayRRule(
  RecurrenceRule recurrenceRule,
  DateTime day,
  DateTime? startDay,
) {
  return recurrenceRule
      .getInstances(
        start: startDay ?? day,
        after: day,
        before: day.add(const Duration(days: 1)),
        includeAfter: true,
        includeBefore: false,
      )
      .take(1)
      .isNotEmpty;
}

bool _hasOnDayRange(
  DateTime day,
  DateTime? startDay,
  DateTime? endDay,
) {
  bool exists = false;
  if (startDay != null && endDay != null) {
    exists = isBeforeOrEqualTo(startDay, day) && endDay.isAfter(day);
  } else if (startDay != null) {
    exists = isBeforeOrEqualTo(startDay, day);
  } else if (endDay != null) {
    exists = endDay.isAfter(day);
  }
  return exists;
}

_hasIfWeekendRRule(
  RecurrenceRule recurrenceRule,
  DateTime day,
  DateTime? startDay,
  Duration? duration,
) {
  final durationDays = duration?.inDays ?? 1;
  bool hasWeekend = false;
  if (day.weekday <= durationDays) {
    bool hasEvent = false;
    for (int i = durationDays + 1; i >= 1; i--) {
      final d = day.subtract(Duration(days: i));
      if (startDay != null && d.isBefore(startDay)) continue;

      final isWeekend =
          d.weekday == DateTime.saturday || d.weekday == DateTime.sunday;
      if (!_hasOnDayRRule(recurrenceRule, d, startDay)) {
        if (!isWeekend && hasEvent) {
          return false;
        }
      } else {
        hasEvent = true;
        hasWeekend = hasWeekend || isWeekend;
      }
    }
  }
  return hasWeekend;
}

_hasIfWeekendRange(
  DateTime day,
  DateTime? startDay,
  DateTime? endDay,
  Duration? duration,
) {
  final durationDays = duration?.inDays ?? 1;
  bool hasWeekend = false;
  if (day.weekday <= durationDays) {
    bool hasEvent = false;
    for (int i = durationDays + 1; i > 0; i--) {
      final d = day.subtract(Duration(days: i));
      if (startDay != null && d.isBefore(startDay)) continue;

      final isWeekend =
          d.weekday == DateTime.saturday || d.weekday == DateTime.sunday;

      if (!_hasOnDayRange(d, startDay, endDay)) {
        if (!isWeekend && hasEvent) {
          return false;
        }
      } else {
        hasEvent = true;
        hasWeekend = hasWeekend || isWeekend;
      }
    }
  }
  return hasWeekend;
}
