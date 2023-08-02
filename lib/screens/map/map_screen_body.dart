import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:traveltime/providers/map_fit_bounds.dart';
import 'package:traveltime/providers/map_follow_location.dart';
import 'package:traveltime/providers/map_tap_position.dart';
import 'package:traveltime/screens/map/widgets/map/map_current_location.dart';
import 'package:traveltime/screens/map/widgets/map/map_current_location_select.dart';
import 'package:traveltime/screens/map/widgets/map/map_markers.dart';
// import 'package:traveltime/screens/map/widgets/map/map_routes.dart';
import 'package:traveltime/screens/map/widgets/map/weather_tiles.dart';
import 'package:traveltime/screens/map/widgets/map/map_tiles_select.dart';
import 'package:traveltime/screens/map/widgets/map/osm_tile_layer.dart';
import 'package:traveltime/screens/map/widgets/popover/popover.dart';
import 'package:traveltime/widgets/map/attribution.dart';
import 'package:traveltime/providers/marker_popover.dart';

// class CachedNetworkTileProvider extends NetworkTileProvider {
//   @override
//   ImageProvider getImage(TileCoordinates coordinates, TileLayer options) => NetworkImage(
//         getTileUrl(coordinates, options),
//         headers: headers,
//       );
// }

class MapScreenBody extends ConsumerWidget {
  const MapScreenBody({super.key, this.mc});

  final MapController? mc;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print('>>>>>123<<<<<');
    ref.listen(mapFitBoundsProvider, (previous, next) {
      print('>>>>>2 ${next?.southEast} ${next?.northWest}');
      mc?.fitBounds(
        next!,
        options: const FitBoundsOptions(
          padding: EdgeInsets.symmetric(
            vertical: 100,
            horizontal: 40,
          ),
        ),
      );
    });

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
        WeatherTiles(),
        // MapRoutes(),
        MapCurrentLocation(),
        MapMarkers(),
      ],
    );
  }
}
