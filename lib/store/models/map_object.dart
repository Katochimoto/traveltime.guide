import 'package:flutter_map/flutter_map.dart';
import 'package:isar/isar.dart';

abstract class MapObject {
  Id get isarId;
  @ignore
  LatLngBounds get bounds;
}
