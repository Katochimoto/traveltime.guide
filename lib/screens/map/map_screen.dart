import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
// import 'package:positioned_tap_detector_2/positioned_tap_detector_2.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:traveltime/constants/Theme.dart';
import 'package:traveltime/constants/routes.dart';
import 'package:traveltime/widgets/map/attribution.dart';
import 'package:traveltime/widgets/map/fast_markers.dart';
import 'package:traveltime/widgets/map/zoom_buttons.dart';
import 'package:traveltime/widgets/navbar/navbar.dart';
import 'package:traveltime/widgets/drawer/drawer.dart';

final redPaint = Paint()
  ..color = Colors.red
  ..style = PaintingStyle.fill;

// Stack(
//           alignment: Alignment.center,
//           children: [
//             Container(
//               child: FlutterMap(
//                 options: MapOptions(
//                   center: LatLng(51.5, -0.09),
//                   zoom: 5,
//                 ),
//                 nonRotatedChildren: [
//                   AttributionWidget.defaultWidget(
//                     source: 'OpenStreetMap contributors',
//                     onSourceTapped: () {},
//                   ),
//                 ],
//                 children: [
//                   TileLayer(
//                     urlTemplate:
//                         'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
//                     userAgentPackageName: 'dev.fleaflet.flutter_map.example',
//                   ),
//                   MarkerLayer(markers: markers),
//                 ],
//               ),
//             ),
//           ],
//         )

// final markers = <Marker>[
//       Marker(
//         width: 80,
//         height: 80,
//         point: LatLng(51.5, -0.09),
//         builder: (ctx) => const FlutterLogo(
//           textColor: Colors.blue,
//           key: ObjectKey(Colors.blue),
//         ),
//       ),
//       Marker(
//         width: 80,
//         height: 80,
//         point: LatLng(53.3498, -6.2603),
//         builder: (ctx) => const FlutterLogo(
//           textColor: Colors.green,
//           key: ObjectKey(Colors.green),
//         ),
//       ),
//       Marker(
//         width: 80,
//         height: 80,
//         point: LatLng(48.8566, 2.3522),
//         builder: (ctx) => const FlutterLogo(
//           textColor: Colors.purple,
//           key: ObjectKey(Colors.purple),
//         ),
//       ),
//     ];

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
        body: _body(context),
      ),
    );
  }

  Widget _body(BuildContext context) {
    final tapStream = StreamController<Offset?>();
    return Stack(alignment: Alignment.topCenter, children: [
      FlutterMap(
        options: MapOptions(
          center: LatLng(51.5, -0.09),
          zoom: 3,
          maxZoom: 17,
          minZoom: 3,
          interactiveFlags: InteractiveFlag.all & ~InteractiveFlag.rotate,
          onTap: (tapPosition, point) {
            tapStream.add(tapPosition.global);
          },
          onPositionChanged: (MapPosition position, bool hasGesture) {
            // positionStream.add(position);
          },
        ),
        children: [
          TileLayer(
            // urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: const ['a', 'b', 'c'],
            userAgentPackageName: 'guide.traveltime.app',
            retinaMode: false, // MediaQuery.of(context).devicePixelRatio > 1.0,
          ),
          // MarkerLayer(
          //   markers: [
          //     Marker(
          //       point: LatLng(51.5, -0.09),
          //       width: 40,
          //       height: 40,
          //       builder: (_) => const Icon(Icons.location_on, size: 40),
          //       anchorPos: AnchorPos.align(AnchorAlign.top),
          //     ),
          //   ],
          // ),
          FastMarkersLayer(
            tapStream: tapStream.stream,
            markers: [
              FastMarker(
                point: LatLng(51.5, -0.09),
                width: 30,
                height: 30,
                anchorPos: AnchorPos.align(AnchorAlign.center),
                onDraw: (canvas, offset) {
                  canvas.drawCircle(
                    offset + const Offset(30 / 2, 30 / 2),
                    30 / 2,
                    redPaint,
                  );
                },
                onTap: () {
                  print('>>>>!!!');
                },
              ),
            ],
          ),
          PolygonLayer(
            polygonCulling: false,
            polygons: [
              Polygon(
                points: [
                  LatLng(30, 40),
                  LatLng(20, 50),
                  LatLng(25, 45),
                ],
                color: Colors.blue,
              ),
            ],
          ),
          PolylineLayer(
            polylineCulling: false,
            polylines: [
              Polyline(
                points: [
                  LatLng(30, 40),
                  LatLng(20, 50),
                  LatLng(25, 45),
                ],
                color: Colors.blue,
              ),
            ],
          ),
          const Attribution(),
        ],
      ),
      // const Text('flutter_map | © OpenStreetMap contributors'),
    ]);
  }

  Widget _panel(BuildContext context, ScrollController sc) {
    return MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child:
            ListView(controller: sc, children: const <Widget>[Text('asdasd')]));
  }
}
