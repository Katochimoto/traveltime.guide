import 'package:duration/duration.dart';
import 'package:intl/intl.dart';
import 'package:isar/isar.dart';
import 'package:rrule/rrule.dart';
import 'package:traveltime/providers/app_auth.dart';
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
}

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

  @Enumerated(EnumType.name)
  final AppLocale locale;

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

  @ignore
  Duration? get durationObject =>
      duration?.isEmpty ?? true ? null : tryParseDurationAny(duration!);

  bool hasOnDay(DateTime date) {
    final day = date.copyWith(
      isUtc: true,
      hour: 0,
      minute: 0,
      second: 0,
      millisecond: 0,
    );

    bool exists = true;

    if (rrule != null) {
      final RecurrenceRule recurrenceRule = RecurrenceRule.fromString(rrule!);
      exists = recurrenceRule
          .getInstances(
            start: day,
            after: day,
            before: day.add(const Duration(days: 1)),
            includeAfter: true,
            includeBefore: false,
          )
          .take(1)
          .isNotEmpty;
    }

    if (dtstart != null && dtend != null) {
      final startDay =
          DateTime.utc(dtstart!.year, dtstart!.month, dtstart!.day);
      final endDay = DateTime.utc(dtend!.year, dtend!.month, dtend!.day);
      exists = exists &&
          (startDay.isBefore(day) || startDay.isAtSameMomentAs(day)) &&
          endDay.isAfter(day);
    } else if (dtstart != null) {
      final startDay =
          DateTime.utc(dtstart!.year, dtstart!.month, dtstart!.day);
      exists =
          exists && (startDay.isBefore(day) || startDay.isAtSameMomentAs(day));
    } else if (dtend != null) {
      final endDay = DateTime.utc(dtend!.year, dtend!.month, dtend!.day);
      exists = exists && endDay.isAfter(day);
    } else if (rrule == null) {
      exists = false;
    }

    return exists;
  }

  EventInstance? instanceOnDay(DateTime date) {
    final day = date.copyWith(
      isUtc: true,
      hour: 0,
      minute: 0,
      second: 0,
      millisecond: 0,
    );

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
    final day = date
        .copyWith(
          isUtc: true,
          hour: 0,
          minute: 0,
          second: 0,
          millisecond: 0,
        )
        .add(const Duration(days: 1));

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
      locale: AppLocale.values.byName(data['locale']),
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
    );
  }

  static List<Event> fromJsonList(List<dynamic> data) {
    return data
        .map<Event>((item) => Event.fromJson(item))
        .toList(growable: false);
  }
}
