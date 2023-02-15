import 'package:isar/isar.dart';
import 'package:traveltime/utils/app_auth.dart';
import 'package:traveltime/utils/fast_hash.dart';

part 'point.g.dart';

enum PointCategory {
  entertainment,
  events,
  attraction,
}

@collection
class Point {
  Point(
      {required this.id,
      required this.lat,
      required this.lng,
      required this.locale,
      required this.createdAt,
      required this.updatedAt,
      required this.publishedAt,
      required this.title,
      required this.description,
      required this.category,
      this.intro,
      this.logoImg,
      this.coverImg});

  final String id;

  Id get isarId => fastHash(id);

  final float lat;
  final float lng;

  @enumerated
  final AppLocale locale;

  @enumerated
  final PointCategory category;

  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime publishedAt;

  @Index(type: IndexType.value)
  final String title;
  final String description;
  final String? intro;
  final String? logoImg;
  final String? coverImg;

  factory Point.fromJson(data) {
    return Point(
      id: data['id'],
      lat: data['lat'],
      lng: data['lng'],
      locale: AppLocale.values.byName(data['locale']),
      category: PointCategory.values.byName(data['category']),
      createdAt: DateTime.parse(data['createdAt']),
      updatedAt: DateTime.parse(data['updatedAt']),
      publishedAt: DateTime.parse(data['publishedAt']),
      title: data['title'],
      intro: data['intro'],
      description: data['description'],
      logoImg: data['logoImg'],
      coverImg: data['coverImg'],
    );
  }
}
