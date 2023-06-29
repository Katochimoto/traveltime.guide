import 'package:flutter_map/plugin_api.dart';
import 'package:isar/isar.dart';

abstract class MapObject {
  Id get isarId;
  @ignore
  LatLngBounds get bounds;
}
