import 'package:flutter_map/plugin_api.dart';
import 'package:isar/isar.dart';
import 'package:latlong2/latlong.dart' as ll;
import 'package:traveltime/providers/app_auth.dart';
import 'package:traveltime/store/models/map_object.dart';
import 'package:traveltime/utils/fast_hash.dart';

part 'point.g.dart';

enum PointCategory {
  entertainment,
  event,
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
class Point implements MapObject {
  Point({
    required this.id,
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
    this.coverImg,
    this.web,
  });

  @Index(unique: true, type: IndexType.value)
  final String id;

  @override
  Id get isarId => fastHash(id);

  final float lat;
  final float lng;

  @Enumerated(EnumType.name)
  final AppLocale locale;

  @Enumerated(EnumType.name)
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
  final String? web;

  @override
  @ignore
  LatLngBounds get bounds => LatLngBounds(
        ll.LatLng(lat, lng),
        ll.LatLng(lat, lng),
      );

  @ignore
  ll.LatLng get coordinates => ll.LatLng(lat, lng);

  factory Point.fromJson(data) {
    return Point(
      id: data['id'],
      lat: double.parse(data['lat'].toString()),
      lng: double.parse(data['lng'].toString()),
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
      web: data['web'],
    );
  }

  static List<Point> fromJsonList(List<dynamic> data) {
    return data
        .map<Point>((item) => Point.fromJson(item))
        .toList(growable: false);
  }
}
