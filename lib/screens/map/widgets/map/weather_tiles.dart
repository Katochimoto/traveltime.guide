import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:traveltime/providers/map_weather_tiles.dart';
import 'package:traveltime/utils/env.dart';

const tileApiLayer = {
  MapWeatherTile.precipitation: 'precipitation_new',
  MapWeatherTile.wind: 'wind_new',
  MapWeatherTile.clouds: 'clouds_new',
  MapWeatherTile.temp: 'temp_new'
};

class WeatherTiles extends ConsumerWidget {
  const WeatherTiles({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tileType = ref.watch(mapWeatherTilesProvider);
    if (tileType == MapWeatherTile.none) {
      return const SizedBox.shrink();
    }

    // https://www.openrailwaymap.org/
    // https://c.tiles.openrailwaymap.org/standard/{z}/{x}/{y}.png

    return TileLayer(
      // @see https://openweathermap.org/api/weathermaps
      urlTemplate:
          'https://tile.openweathermap.org/map/${tileApiLayer[tileType]}/{z}/{x}/{y}.png?appid=${Env.openWeatherApi}',
      userAgentPackageName: 'guide.traveltime.app',
      retinaMode: false,
      minZoom: 3,
      maxZoom: 10,
      errorImage: const AssetImage('assets/imgs/empty_tile.png'),
      tileProvider: NetworkTileProvider(),
      backgroundColor: const Color.fromRGBO(0, 0, 0, 0),
    );
  }
}
