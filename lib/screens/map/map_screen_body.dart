import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:traveltime/providers/map_follow_location.dart';
import 'package:traveltime/providers/map_tap_position.dart';
import 'package:traveltime/screens/map/map_current_location.dart';
import 'package:traveltime/screens/map/map_current_location_select.dart';
import 'package:traveltime/screens/map/map_markers.dart';
import 'package:traveltime/screens/map/map_routes.dart';
import 'package:traveltime/screens/map/map_tiles.dart';
import 'package:traveltime/screens/map/map_tiles_select.dart';
import 'package:traveltime/widgets/map/attribution.dart';
import 'package:traveltime/widgets/map/popover.dart';
import 'package:traveltime/providers/marker_popover.dart';

class CachedNetworkTileProvider extends NetworkTileProvider {
  @override
  ImageProvider getImage(Coords<num> coords, TileLayer options) =>
      CachedNetworkImageProvider(
        getTileUrl(coords, options),
        headers: headers,
      );
}

class OSMTileLayer extends StatelessWidget {
  const OSMTileLayer({super.key});

  @override
  Widget build(BuildContext context) {
    return TileLayer(
      urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
      subdomains: const ['a', 'b', 'c'],
      userAgentPackageName: 'guide.traveltime.app',
      retinaMode: false, // MediaQuery.of(context).devicePixelRatio > 1.0,
      minZoom: 3,
      maxZoom: 18,
      // maybe https://github.com/flutter/packages/tree/main/packages/flutter_image
      tileProvider: CachedNetworkTileProvider(),
      errorImage: const AssetImage('assets/imgs/empty_tile.png'),
      // backgroundColor: const Color.fromRGBO(0, 0, 0, 0),
    );
  }
}

class MapScreenBody extends ConsumerWidget {
  const MapScreenBody({super.key, this.mc});

  final MapController? mc;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FlutterMap(
      mapController: mc,
      options: MapOptions(
        zoom: 3,
        maxZoom: 18,
        minZoom: 3,
        interactiveFlags: InteractiveFlag.all & ~InteractiveFlag.rotate,
        onTap: (tapPosition, point) {
          ref.read(popoverProvider.notifier).hide();
          ref.read(mapTapPositionProvider.notifier).tap(tapPosition.global);
        },
        onPositionChanged: (MapPosition position, bool hasGesture) {
          ref.read(popoverProvider.notifier).hide();
          ref.read(mapFollowLocationProvider.notifier).never();
        },
      ),
      nonRotatedChildren: const [
        MapTilesSelect(),
        MapCurrentLocationSelect(),
        Attribution(),
        Popover(),
      ],
      children: const [
        OSMTileLayer(),
        MapTiles(),
        MapCurrentLocation(),
        MapMarkers(),
        MapRoutes(),
      ],
    );
  }
}
