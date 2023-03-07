import 'package:flutter_riverpod/flutter_riverpod.dart';

enum MapWeatherTile {
  none,
  precipitation,
  clouds,
  wind,
  temp,
}

class MapWeatherTiles extends Notifier<MapWeatherTile> {
  @override
  MapWeatherTile build() {
    return MapWeatherTile.none;
  }

  void set(MapWeatherTile tileType) {
    if (state != tileType) {
      state = tileType;
    }
  }

  void clear() {
    set(MapWeatherTile.none);
  }
}

final mapWeatherTilesProvider =
    NotifierProvider<MapWeatherTiles, MapWeatherTile>(() {
  return MapWeatherTiles();
});
