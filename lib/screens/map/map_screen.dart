import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:traveltime/constants/Theme.dart';
import 'package:traveltime/constants/routes.dart';
import 'package:traveltime/widgets/map/zoom_buttons.dart';
import 'package:traveltime/widgets/navbar/navbar.dart';
import 'package:traveltime/widgets/drawer/drawer.dart';

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
      appBar: Navbar(
        title: AppLocalizations.of(context)!.settingsTitle,
        isTransparent: true,
      ),
      drawer: const AppDrawer(currentPage: Routes.map),
      body: SlidingUpPanel(
        maxHeight: MediaQuery.of(context).size.height * 0.75,
        minHeight: 100,
        parallaxEnabled: true,
        parallaxOffset: .5,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(18.0), topRight: Radius.circular(18.0)),
        // panel: const Center(
        //   child: Text("This is the sliding Widget"),
        // ),
        panelBuilder: (sc) => _panel(context, sc),
        body: _body(context),
      ),
    );
  }

  Widget _body(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        center: LatLng(51.5, -0.09),
        zoom: 5,
        maxZoom: 17,
        minZoom: 5,
        interactiveFlags: InteractiveFlag.all & ~InteractiveFlag.rotate,
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'guide.traveltime.app',
          retinaMode: false, // MediaQuery.of(context).devicePixelRatio > 1.0,
        ),
      ],
    );
  }

  Widget _panel(BuildContext context, ScrollController sc) {
    return MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: ListView(controller: sc, children: <Widget>[
          // Text("This is the sliding Widget"),
        ]));
  }
}
