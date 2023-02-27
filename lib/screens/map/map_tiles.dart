import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:traveltime/providers/app_auth.dart';

class SelectTiles extends ConsumerWidget {
  const SelectTiles({super.key});

  List<DropdownMenuItem<AppTheme>> get themes {
    List<DropdownMenuItem<AppTheme>> menuItems = [
      DropdownMenuItem(
        value: AppTheme.system,
        child: Row(children: const [
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
      DropdownMenuItem(
        value: AppTheme.dark,
        child: Row(children: const [
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
      DropdownMenuItem(
        value: AppTheme.light,
        child: Row(children: const [
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
      DropdownMenuItem(
        value: AppTheme.light,
        child: Row(children: const [
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
    ];
    return menuItems;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final authorized = ref.watch(appAuthProvider).value;

    return DropdownButtonHideUnderline(
        child: DropdownButton2(
      // underline: Container(),
      // alignment: AlignmentDirectional.bottomEnd,
      customButton: const FloatingActionButton(
        heroTag: 'map_tiles',
        onPressed: null,
        child: Icon(
          Icons.layers,
          size: 25,
        ),
      ),
      items: themes,
      // value: authorized?.theme,
      onChanged: (value) {
        // ref.watch(appAuthProvider.notifier).updateTheme(value);
      },
      dropdownWidth: 200,
      dropdownOverButton: true,
      // offset: const Offset(0, -8),
    ));
  }
}

class MapTiles extends ConsumerStatefulWidget {
  const MapTiles({super.key});

  @override
  ConsumerState<MapTiles> createState() => MapTilesState();
}

class MapTilesState extends ConsumerState<MapTiles> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didUpdateWidget(covariant MapTiles oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final followOnLocationUpdate = ref.watch(mapFollowLocationProvider);
    return Stack(
      children: [
        // TileLayer(
        //   opacity: 0.5,
        //   urlTemplate:
        //       'https://tile.openweathermap.org/map/precipitation_new/{z}/{x}/{y}.png?appid=27b74938c3db783a84f6d0722ea2bdba',
        //   userAgentPackageName: 'guide.traveltime.app',
        //   retinaMode: false,
        //   minZoom: 3,
        //   maxZoom: 10,
        //   errorImage: const CachedNetworkImageProvider(
        //       'https://tile.openstreetmap.org/18/0/0.png'),
        //   tileProvider: NetworkTileProvider(),
        // ),
        Positioned(
          right: 20,
          bottom: 220,
          child: SelectTiles(),
          //  FloatingActionButton(
          //   onPressed: () {},
          //   child: const Icon(
          //     Icons.layers,
          //     size: 25,
          //   ),
          // ),
        ),
      ],
    );
  }
}
