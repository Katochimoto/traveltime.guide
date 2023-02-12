import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart' as ll;
// import 'package:positioned_tap_detector_2/positioned_tap_detector_2.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:traveltime/constants/Theme.dart';
import 'package:traveltime/constants/routes.dart';
import 'package:traveltime/screens/map/map_markers.dart';
import 'package:traveltime/screens/map/marks.dart';
import 'package:traveltime/screens/map/overview.dart';
import 'package:traveltime/widgets/map/attribution.dart';
import 'package:traveltime/widgets/map/fast_markers.dart';
import 'package:traveltime/widgets/map/popover.dart';
import 'package:traveltime/widgets/navbar/navbar.dart';
import 'package:traveltime/widgets/drawer/drawer.dart';
import 'package:traveltime/widgets/navbar/navbar_categories.dart';

class MapScreen extends ConsumerWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const Navbar(
        isTransparent: true,
      ),
      drawer: const AppDrawer(currentPage: Routes.map),
      body: SlidingUpPanel(
        maxHeight: MediaQuery.of(context).size.height * 0.75,
        minHeight: 100,
        parallaxEnabled: true,
        parallaxOffset: .5,
        color: Theme.of(context).canvasColor,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(UIGap.g3),
            topRight: Radius.circular(UIGap.g3)),
        // panel: const Center(
        //   child: Text("This is the sliding Widget"),
        // ),
        panelBuilder: (sc) => _panel(context, sc),
        body: _body(context, ref),
        // collapsed: Container(
        //   color: Colors.blueGrey,
        //   child: Center(
        //     child: Text(
        //       "This is the collapsed Widget",
        //       style: TextStyle(color: Colors.white),
        //     ),
        //   ),
        // ),
      ),
    );
  }

  Widget _body(BuildContext context, WidgetRef ref) {
    return Stack(alignment: Alignment.topCenter, children: [
      FlutterMap(
        options: MapOptions(
          center: ll.LatLng(51.5, -0.09),
          zoom: 3,
          maxZoom: 18,
          minZoom: 3,
          interactiveFlags: InteractiveFlag.all & ~InteractiveFlag.rotate,
          onTap: (tapPosition, point) {
            ref.read(popoverPositionProvider.notifier).hide();
            ref.read(mapTapPositionProvider.notifier).tap(tapPosition.global);
          },
          onPositionChanged: (MapPosition position, bool hasGesture) {
            ref.read(popoverPositionProvider.notifier).hide();
          },
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://{s}.tile.openstreetmap.de/{z}/{x}/{y}.png',
            subdomains: const ['a', 'b', 'c'],
            userAgentPackageName: 'guide.traveltime.app',
            retinaMode: false, // MediaQuery.of(context).devicePixelRatio > 1.0,
            minZoom: 3,
            maxZoom: 18,
            tileProvider: NetworkTileProvider(),
          ),
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
          PolygonLayer(
            polygonCulling: false,
            polygons: [
              Polygon(
                points: [
                  ll.LatLng(12.910540799939268, 100.8561218137046),
                  ll.LatLng(12.908788526202928, 100.85827079011717),
                  ll.LatLng(12.91007552400327, 100.86500995068457),
                ],
                color: Colors.blue.withAlpha(50),
                isFilled: true,
              ),
            ],
          ),
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
          const MapPopover(),
        ],
      ),
    ]);
  }

  Widget _panel(BuildContext context, ScrollController sc) {
    return MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: Stack(
          alignment: AlignmentDirectional.topCenter,
          children: [
            // Overview(sc: sc),
            Column(
              children: [
                const SizedBox(height: 15),
                const NavbarCategories(),
                Expanded(child: Marks(sc: sc)),
              ],
            ),
            Container(
              transform: Matrix4.translationValues(0, -10, 0),
              child: Icon(
                Icons.horizontal_rule,
                color: Theme.of(context).dividerColor,
                size: 40.0,
              ),
            ),
          ],
        ));
  }
}
