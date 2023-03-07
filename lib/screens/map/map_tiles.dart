import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:traveltime/providers/map_weather_tiles.dart';

const tileApiLayer = {
  MapWeatherTile.precipitation: 'precipitation_new',
  MapWeatherTile.wind: 'wind_new',
  MapWeatherTile.clouds: 'clouds_new',
  MapWeatherTile.temp: 'temp_new'
};

class MapTiles extends ConsumerWidget {
  const MapTiles({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tileType = ref.watch(mapWeatherTilesProvider);
    if (tileType == MapWeatherTile.none) {
      return const SizedBox.shrink();
    }

    return TileLayer(
      urlTemplate:
          // 'http://maps.openweathermap.org/maps/2.0/weather/PR0/{z}/{x}/{y}?appid=27b74938c3db783a84f6d0722ea2bdba',
          'https://tile.openweathermap.org/map/${tileApiLayer[tileType]}/{z}/{x}/{y}.png?appid=27b74938c3db783a84f6d0722ea2bdba',
      userAgentPackageName: 'guide.traveltime.app',
      retinaMode: false,
      minZoom: 3,
      maxZoom: 10,
      errorImage: const AssetImage('assets/imgs/empty_tile.png'),
      tileProvider: NetworkTileProvider(),
      overrideTilesWhenUrlChanges: true,
      backgroundColor: const Color.fromRGBO(0, 0, 0, 0),
    );
  }
}
