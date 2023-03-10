import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:traveltime/providers/map_follow_location.dart';
import 'package:traveltime/providers/map_tap_position.dart';
import 'package:traveltime/screens/map/map_current_location.dart';
import 'package:traveltime/screens/map/map_markers.dart';
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

class MapScreenBody extends ConsumerWidget {
  const MapScreenBody({super.key, this.mc});

  final MapController? mc;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        FlutterMap(
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
          children: [
            TileLayer(
              urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
              subdomains: const ['a', 'b', 'c'],
              userAgentPackageName: 'guide.traveltime.app',
              retinaMode:
                  false, // MediaQuery.of(context).devicePixelRatio > 1.0,
              minZoom: 3,
              maxZoom: 18,
              // maybe https://github.com/flutter/packages/tree/main/packages/flutter_image
              tileProvider: CachedNetworkTileProvider(),
              errorImage: const AssetImage('assets/imgs/empty_tile.png'),
              // backgroundColor: const Color.fromRGBO(0, 0, 0, 0),
            ),
            const MapTiles(),
            const MapCurrentLocation(),
            const MapMarkers(),
            // MarkerLayer(
            //   markers: [
            //     Marker(
            //       point: ll.LatLng(12.910540799939268, 100.8561218137046),
            //       width: 20,
            //       height: 20,
            //       builder: (_) => const Icon(Icons.location_on, size: 20),
            //       anchorPos: AnchorPos.align(AnchorAlign.top),
            //     ),
            //   ],
            // ),
            // PolygonLayer(
            //   polygonCulling: false,
            //   polygons: [
            //     Polygon(
            //       points: [
            //         ll.LatLng(12.910540799939268, 100.8561218137046),
            //         ll.LatLng(12.908788526202928, 100.85827079011717),
            //         ll.LatLng(12.91007552400327, 100.86500995068457),
            //       ],
            //       color: Colors.blue.withAlpha(50),
            //       isFilled: true,
            //     ),
            //   ],
            // ),
            // PolylineLayer(
            //   polylineCulling: false,
            //   polylines: [
            //     Polyline(
            //       strokeWidth: 2,
            //       points: [
            //         ll.LatLng(12.910540799939268, 100.8561218137046),
            //         ll.LatLng(12.908788526202928, 100.85827079011717),
            //         ll.LatLng(12.91007552400327, 100.86500995068457),
            //       ],
            //       color: Colors.blue,
            //     ),
            //   ],
            // ),
            const Attribution(),
            const Popover(),
          ],
        ),
        const MapTilesSelect(),
      ],
    );
  }
}
