import 'package:isar/isar.dart';
import 'package:rrule/rrule.dart';
import 'package:traveltime/providers/app_auth.dart';
import 'package:traveltime/utils/fast_hash.dart';

part 'event.g.dart';

@collection
class Event {
  Event({
    required this.id,
    required this.country,
    required this.locale,
    required this.createdAt,
    required this.updatedAt,
    required this.publishedAt,
    required this.title,
    required this.description,
    required this.rrule,
    required this.duration,
    this.intro,
    this.logoImg,
    this.coverImg,
    this.points,
  });

  final String id;

  Id get isarId => fastHash(id);

  final String country;

  @enumerated
  final AppLocale locale;

  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime publishedAt;

  @Index(type: IndexType.value)
  final String title;
  final String description;
  final String rrule;
  final String duration;
  final String? intro;
  final String? logoImg;
  final String? coverImg;

  @Index(type: IndexType.value)
  final List<String>? points;

  @ignore
  RecurrenceRule get recurrenceRule => RecurrenceRule.fromString(rrule);

  Iterable<DateTime> getDayInstances({
    required DateTime date,
  }) =>
      recurrenceRule.getInstances(
        start: date,
        after: date,
        before: date.add(const Duration(days: 1)),
        includeAfter: true,
        includeBefore: false,
      );

  factory Event.fromJson(data) {
    return Event(
      id: data['id'],
      country: data['country'],
      locale: AppLocale.values.byName(data['locale']),
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
    );
  }
}
