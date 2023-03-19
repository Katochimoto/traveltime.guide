import 'package:duration/duration.dart';
import 'package:isar/isar.dart';
import 'package:rrule/rrule.dart';
import 'package:traveltime/providers/app_auth.dart';
import 'package:traveltime/utils/fast_hash.dart';

part 'event.g.dart';

class EventInstance {
  final DateTime start;
  final DateTime? end;
  final Duration? duration;

  EventInstance({
    required this.start,
    this.end,
    this.duration,
  });
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
    this.dtstart,
    this.dtend,
  });

  final String id;

  Id get isarId => fastHash(id);

  final String country;

  @enumerated
  final AppLocale locale;

  @enumerated
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

  @ignore
  Duration? get durationObject =>
      duration!.isEmpty ? null : tryParseDurationAny(duration!);

  bool hasOnDay(DateTime date) {
    bool exists = true;

    if (rrule != null) {
      final RecurrenceRule recurrenceRule = RecurrenceRule.fromString(rrule!);
      exists = recurrenceRule
          .getInstances(
            start: date,
            after: date,
            before: date.add(const Duration(days: 1)),
            includeAfter: true,
            includeBefore: dtend != null,
          )
          .take(1)
          .isNotEmpty;
    }

    if (dtstart != null && dtend != null) {
      final startDay =
          DateTime.utc(dtstart!.year, dtstart!.month, dtstart!.day);
      final endDay = DateTime.utc(dtend!.year, dtend!.month, dtend!.day)
          .add(const Duration(days: 1));
      exists = exists &&
          (startDay.isBefore(date) || startDay.isAtSameMomentAs(date)) &&
          endDay.isAfter(date);
    } else if (dtstart != null) {
      final startDay =
          DateTime.utc(dtstart!.year, dtstart!.month, dtstart!.day);
      exists = exists &&
          (startDay.isBefore(date) || startDay.isAtSameMomentAs(date));
    } else if (dtend != null) {
      final endDay = DateTime.utc(dtend!.year, dtend!.month, dtend!.day)
          .add(const Duration(days: 1));
      exists = exists && endDay.isAfter(date);
    } else if (rrule == null) {
      exists = false;
    }

    return exists;
  }

  DateTime? instanceOnDay(DateTime date) {
    // DateTime? start = null;
    // DateTime? end = null;

    // if (rrule != null) {
    //   final RecurrenceRule recurrenceRule = RecurrenceRule.fromString(rrule!);
    //   final instances = recurrenceRule
    //       .getInstances(
    //         start: date,
    //         after: date,
    //         before: date.add(const Duration(days: 1)),
    //         includeAfter: true,
    //         includeBefore: false,
    //       )
    //       .take(1);

    //   if (instances.isNotEmpty) {
    //     start = instances.first;
    //     end = durationObject != null
    //         ? instances.first.add(durationObject!)
    //         : instances.first;
    //   }
    // } else if (dtstart != null && dtend != null) {
    //   start = dtstart;
    //   end = dtend;
    // } else if (dtstart != null) {
    //   start = dtstart;
    // } else if (dtend != null) {
    //   end = dtend;
    // }

    return null;
  }

  DateTime? upcomingInstanceFrom(DateTime date) {}

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
    );
  }
}
