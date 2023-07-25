import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:traveltime/constants/_theme.dart';
import 'package:traveltime/constants/routes.dart';
import 'package:traveltime/screens/map/map_screen_body.dart';
import 'package:traveltime/screens/map/map_screen_panel.dart';
import 'package:traveltime/widgets/navbar/navbar.dart';
import 'package:traveltime/widgets/drawer/drawer.dart';

class MapScreenContent extends StatelessWidget {
  MapScreenContent({super.key});

  final PanelController pc = PanelController();
  final MapController mc = MapController();

  @override
  Widget build(BuildContext context) {
    return SlidingUpPanel(
      controller: pc,
      maxHeight: MediaQuery.of(context).size.height * 0.75,
      minHeight: 100,
      parallaxEnabled: true,
      parallaxOffset: .5,
      color: Theme.of(context).canvasColor,
      borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(UIGap.g3),
          topRight: Radius.circular(UIGap.g3)),
      panelBuilder: (sc) => MapScreenPanel(sc: sc, pc: pc, mc: mc),
      body: MapScreenBody(mc: mc),
      // collapsed: Container(
      //   color: Colors.blueGrey,
      //   child: Center(
      //     child: Text(
      //       "This is the collapsed Widget",
      //       style: TextStyle(color: Colors.white),
      //     ),
      //   ),
      // ),
    );
  }
}

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const Navbar(isTransparent: true),
      drawer: const AppDrawer(currentPage: Routes.map),
      body: MapScreenContent(),
    );
  }
}
