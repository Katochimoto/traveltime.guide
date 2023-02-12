import 'package:isar/isar.dart';
import 'package:traveltime/utils/app_auth.dart';

part 'point.g.dart';

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
      this.intro,
      this.logoImg,
      this.coverImg});

  final Id id;

  final float lat;
  final float lng;

  @enumerated
  final AppLocale locale;

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
