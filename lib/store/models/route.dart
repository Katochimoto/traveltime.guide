import 'package:flutter_map/plugin_api.dart';
import 'package:isar/isar.dart';
import 'package:latlong2/latlong.dart' as ll;
import 'package:traveltime/providers/app_auth.dart';
import 'package:traveltime/utils/fast_hash.dart';

part 'route.g.dart';

@collection
class Route {
  Route({
    required this.id,
    required this.locale,
    required this.createdAt,
    required this.updatedAt,
    required this.publishedAt,
    required this.title,
    required this.description,
    required this.bounds,
    this.intro,
    this.logoImg,
    this.coverImg,
  });

  @Index(unique: true, type: IndexType.value)
  final String id;

  Id get isarId => fastHash(id);

  @enumerated
  final AppLocale locale;

  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime publishedAt;

  @Index(type: IndexType.value)
  final String title;
  final String description;
  final String? intro;
  final List<float> bounds;
  final String? logoImg;
  final String? coverImg;

  @ignore
  LatLngBounds get routeBounds => LatLngBounds(
        ll.LatLng(bounds[0], bounds[1]),
        ll.LatLng(bounds[2], bounds[3]),
      );

  factory Route.fromJson(data) {
    return Route(
      id: data['id'],
      locale: AppLocale.values.byName(data['locale']),
      createdAt: DateTime.parse(data['createdAt']),
      updatedAt: DateTime.parse(data['updatedAt']),
      publishedAt: DateTime.parse(data['publishedAt']),
      title: data['title'],
      intro: data['intro'],
      description: data['description'],
      bounds: [...data['bounds']]
          .map((item) => float.parse(item.toString()))
          .toList(growable: false),
      logoImg: data['logoImg'],
      coverImg: data['coverImg'],
    );
  }

  static List<Route> fromJsonList(List<dynamic> data) {
    return data
        .map<Route>((item) => Route.fromJson(item))
        .toList(growable: false);
  }
}