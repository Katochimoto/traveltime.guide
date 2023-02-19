import 'package:flutter_map/plugin_api.dart';
import 'package:isar/isar.dart';
import 'package:latlong2/latlong.dart' as ll;
import 'package:traveltime/providers/app_auth.dart';
import 'package:traveltime/utils/fast_hash.dart';

part 'point.g.dart';

enum PointCategory {
  entertainment,
  events,
  attraction,
  nightMarket,
  hypermarket,
  beach,
  restaurant,
  cafe,
  marina,
  police,
  gasStation,
  carRental,
  hotel,
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
      this.address,
      this.logoImg,
      this.coverImg});

  final String id;

  Id get isarId => fastHash(id);

  final float lat;
  final float lng;

  @enumerated
  final AppLocale locale;

  @enumerated
  @Index(type: IndexType.value)
  final PointCategory category;

  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime publishedAt;

  @Index(type: IndexType.value)
  final String title;
  final String description;
  final String? intro;
  final String? address;
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
      address: data['address'],
      description: data['description'],
      logoImg: data['logoImg'],
      coverImg: data['coverImg'],
    );
  }

  @ignore
  LatLngBounds get bounds => LatLngBounds(
        ll.LatLng(lat, lng),
        ll.LatLng(lat, lng),
      );
}
