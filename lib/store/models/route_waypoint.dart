import 'package:flutter_map/plugin_api.dart';
import 'package:isar/isar.dart';
import 'package:latlong2/latlong.dart' as ll;
import 'package:traveltime/providers/app_auth.dart';
import 'package:traveltime/utils/fast_hash.dart';

part 'route_waypoint.g.dart';

@collection
class RouteWaypoint {
  RouteWaypoint({
    required this.id,
    required this.locale,
    required this.createdAt,
    required this.updatedAt,
    required this.publishedAt,
    required this.order,
    required this.route,
    this.point,
    this.title,
    this.intro,
    this.lat,
    this.lng,
  });

  @Index(unique: true, type: IndexType.value)
  final String id;

  Id get isarId => fastHash(id);

  @Enumerated(EnumType.name)
  final AppLocale locale;

  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime publishedAt;

  final short order;

  @Index(type: IndexType.value)
  final int? route;

  @Index(type: IndexType.value)
  final int? point;

  final String? title;
  final String? intro;
  final float? lat;
  final float? lng;

  @ignore
  LatLngBounds? get bounds => lat != null && lng != null
      ? LatLngBounds(
          ll.LatLng(lat!, lng!),
          ll.LatLng(lat!, lng!),
        )
      : null;

  factory RouteWaypoint.fromJson(data) {
    return RouteWaypoint(
      id: data['id'],
      locale: AppLocale.values.byName(data['locale']),
      createdAt: DateTime.parse(data['createdAt']),
      updatedAt: DateTime.parse(data['updatedAt']),
      publishedAt: DateTime.parse(data['publishedAt']),
      order: data['order'],
      route: data['route'] != null ? fastHash(data['route']) : null,
      point: data['point'] != null ? fastHash(data['point']) : null,
      title: data['title'],
      intro: data['intro'],
      lat: data['lat'],
      lng: data['lng'],
    );
  }

  static List<RouteWaypoint> fromJsonList(List<dynamic> data) {
    return data
        .map<RouteWaypoint>((item) => RouteWaypoint.fromJson(item))
        .toList(growable: false);
  }
}
