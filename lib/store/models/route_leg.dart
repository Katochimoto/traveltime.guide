import 'package:isar/isar.dart';
import 'package:traveltime/utils/fast_hash.dart';

part 'route_leg.g.dart';

@collection
class RouteLeg {
  RouteLeg({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.route,
    required this.fromWaypoint,
    required this.toWaypoint,
    this.path,
  });

  @Index(unique: true, type: IndexType.value)
  final String id;

  Id get isarId => fastHash(id);

  final DateTime createdAt;
  final DateTime updatedAt;

  @Index(type: IndexType.value)
  final String route;

  final String fromWaypoint;
  final String toWaypoint;
  final String? path;

  factory RouteLeg.fromJson(data) {
    return RouteLeg(
      id: data['id'],
      createdAt: DateTime.parse(data['createdAt']),
      updatedAt: DateTime.parse(data['updatedAt']),
      route: data['route'],
      fromWaypoint: data['fromWaypoint'],
      toWaypoint: data['toWaypoint'],
      path: data['path'],
    );
  }

  static List<RouteLeg> fromJsonList(List<dynamic> data) {
    return data
        .map<RouteLeg>((item) => RouteLeg.fromJson(item))
        .toList(growable: false);
  }
}
