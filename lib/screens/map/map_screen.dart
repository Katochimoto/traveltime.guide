import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:traveltime/constants/Theme.dart';
import 'package:traveltime/constants/routes.dart';
import 'package:traveltime/widgets/map/zoombuttons.dart';
import 'package:traveltime/widgets/navbar/navbar.dart';
import 'package:traveltime/widgets/drawer/drawer.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final markers = <Marker>[
      Marker(
        width: 80,
        height: 80,
        point: LatLng(51.5, -0.09),
        builder: (ctx) => const FlutterLogo(
          textColor: Colors.blue,
          key: ObjectKey(Colors.blue),
        ),
      ),
      Marker(
        width: 80,
        height: 80,
        point: LatLng(53.3498, -6.2603),
        builder: (ctx) => const FlutterLogo(
          textColor: Colors.green,
          key: ObjectKey(Colors.green),
        ),
      ),
      Marker(
        width: 80,
        height: 80,
        point: LatLng(48.8566, 2.3522),
        builder: (ctx) => const FlutterLogo(
          textColor: Colors.purple,
          key: ObjectKey(Colors.purple),
        ),
      ),
    ];

    return Scaffold(
        // extendBodyBehindAppBar: true,
        appBar: Navbar(
          title: AppLocalizations.of(context)!.settingsTitle,
        ),
        drawer: const AppDrawer(currentPage: Routes.map),
        body: Stack(
          alignment: Alignment.center,
          children: [
            // MapZoomButtons(),
            Container(
              child: FlutterMap(
                options: MapOptions(
                  center: LatLng(51.5, -0.09),
                  zoom: 5,
                ),
                // nonRotatedChildren: [
                //   AttributionWidget.defaultWidget(
                //     source: 'OpenStreetMap contributors',
                //     onSourceTapped: () {},
                //   ),
                // ],
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'dev.fleaflet.flutter_map.example',
                  ),
                  MarkerLayer(markers: markers),
                ],
              ),
            ),
            // SafeArea(
            //   child: Column(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //       const Image(
            //           image: AssetImage("assets/imgs/logo3.png"),
            //           width: 80,
            //           height: 80),
            //       const SizedBox(height: UIGap.g4),
            //       Text(
            //         AppLocalizations.of(context)!.appTitle,
            //         style: Theme.of(context).primaryTextTheme.displayMedium,
            //       ),
            //       Text(
            //         AppLocalizations.of(context)!.appSubtitle,
            //         style: Theme.of(context).primaryTextTheme.caption,
            //       ),
            //       const SizedBox(height: UIGap.g4),
            //       TextButton(
            //         style: TextButton.styleFrom(
            //           shape: const StadiumBorder(),
            //         ),
            //         onPressed: () {
            //           context.goNamed(Routes.discover);
            //         },
            //         child: Padding(
            //           padding: const EdgeInsets.symmetric(
            //               horizontal: UIGap.g2, vertical: UIGap.g0),
            //           child: Text(
            //             AppLocalizations.of(context)!.getStarted,
            //             style: Theme.of(context).primaryTextTheme.button,
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // )
          ],
        ));
  }
}
