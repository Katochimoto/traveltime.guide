import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:traveltime/providers/map_weather_tiles.dart';

const tileIcon = {
  MapWeatherTile.none: Icons.layers,
  MapWeatherTile.precipitation: Icons.cloudy_snowing,
  MapWeatherTile.wind: Icons.wind_power,
  MapWeatherTile.clouds: Icons.cloud,
  MapWeatherTile.temp: Icons.thermostat,
};

class SelectTiles extends ConsumerWidget {
  const SelectTiles({super.key});

  List<DropdownMenuItem<MapWeatherTile>> get tileTypes {
    List<DropdownMenuItem<MapWeatherTile>> menuItems = [
      const DropdownMenuItem(
        value: MapWeatherTile.none,
        child: Row(children: [
          Icon(
            Icons.layers_clear,
            size: 22,
          ),
          SizedBox(
            width: 10,
          ),
          Text('Clear')
        ]),
      ),
      const DropdownMenuItem(
        value: MapWeatherTile.precipitation,
        child: Row(children: [
          Icon(
            Icons.cloudy_snowing,
            size: 22,
          ),
          SizedBox(
            width: 10,
          ),
          Text('Precipitation')
        ]),
      ),
      const DropdownMenuItem(
        value: MapWeatherTile.wind,
        child: Row(children: [
          Icon(
            Icons.wind_power,
            size: 22,
          ),
          SizedBox(
            width: 10,
          ),
          Text('Wind speed')
        ]),
      ),
      const DropdownMenuItem(
        value: MapWeatherTile.clouds,
        child: Row(children: [
          Icon(
            Icons.cloud,
            size: 22,
          ),
          SizedBox(
            width: 10,
          ),
          Text('Clouds')
        ]),
      ),
      const DropdownMenuItem(
        value: MapWeatherTile.temp,
        child: Row(children: [
          Icon(
            Icons.thermostat,
            size: 22,
          ),
          SizedBox(
            width: 10,
          ),
          Text('Temperature')
        ]),
      ),
    ];
    return menuItems;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tileType = ref.watch(mapWeatherTilesProvider);

    return DropdownButtonHideUnderline(
        child: DropdownButton2(
      // underline: Container(),
      // alignment: AlignmentDirectional.bottomEnd,
      customButton: FloatingActionButton(
        heroTag: 'map_tiles',
        onPressed: null,
        child: Icon(tileIcon[tileType], size: 25),
      ),
      items: tileTypes,
      value: tileType,
      onChanged: (value) {
        ref
            .watch(mapWeatherTilesProvider.notifier)
            .set(value ?? MapWeatherTile.none);
      },
      dropdownStyleData:
          const DropdownStyleData(width: 200, isOverButton: true),
      // offset: const Offset(0, -8),
    ));
  }
}

class MapTilesSelect extends StatelessWidget {
  const MapTilesSelect({super.key});

  @override
  Widget build(BuildContext context) {
    return const Positioned(
      right: 20,
      bottom: 220,
      child: SelectTiles(),
    );
  }
}
