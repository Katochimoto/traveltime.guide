import 'package:isar/isar.dart';
import 'package:rrule/rrule.dart';
import 'package:traveltime/providers/app_auth.dart';
import 'package:traveltime/utils/fast_hash.dart';

part 'event.g.dart';

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
    this.rrule,
    this.duration,
    this.intro,
    this.logoImg,
    this.coverImg,
    this.points,
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
  final String? rrule;
  final String? duration;
  final String? intro;
  final String? logoImg;
  final String? coverImg;

  @Index(type: IndexType.value)
  final List<String>? points;

  final DateTime? dtstart;
  final DateTime? dtend;

  bool hasOnDay(DateTime date) {
    bool exists = false;

    if (rrule != null) {
      final RecurrenceRule recurrenceRule = RecurrenceRule.fromString(rrule!);
      exists = recurrenceRule
          .getInstances(
            start: date,
            after: date,
            before: date.add(const Duration(days: 1)),
            includeAfter: true,
            includeBefore: false,
          )
          .take(1)
          .isNotEmpty;
    }

    if (dtstart != null && dtend != null) {
      final startDay =
          DateTime.utc(dtstart!.year, dtstart!.month, dtstart!.day);
      final endDay = DateTime.utc(dtend!.year, dtend!.month, dtend!.day)
          .add(const Duration(days: 1));
      exists = (startDay.isBefore(date) || startDay.isAtSameMomentAs(date)) &&
          endDay.isAfter(date);
    } else if (dtstart != null) {
      final startDay =
          DateTime.utc(dtstart!.year, dtstart!.month, dtstart!.day);
      exists = startDay.isBefore(date) || startDay.isAtSameMomentAs(date);
    } else if (dtend != null) {
      final endDay = DateTime.utc(dtend!.year, dtend!.month, dtend!.day)
          .add(const Duration(days: 1));
      exists = endDay.isAfter(date);
    }

    return exists;
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
      points: List<String>.from(data['points']),
      dtstart: data['dtstart'] != null ? DateTime.parse(data['dtstart']) : null,
      dtend: data['dtend'] != null ? DateTime.parse(data['dtend']) : null,
    );
  }
}
