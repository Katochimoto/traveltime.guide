import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:traveltime/constants/theme.dart';
import 'package:traveltime/constants/routes.dart';
import 'package:traveltime/screens/map/map_screen_body.dart';
import 'package:traveltime/screens/map/map_screen_panel.dart';
import 'package:traveltime/widgets/navbar/navbar.dart';
import 'package:traveltime/widgets/drawer/drawer.dart';

class MapScreen extends ConsumerWidget {
  MapScreen({
    super.key,
    this.id,
    this.onBack,
  });

  final PanelController pc = PanelController();
  final MapController mc = MapController();
  final int? id;
  final void Function(BuildContext context, WidgetRef ref)? onBack;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: Navbar(
        isTransparent: true,
        onBack: onBack != null ? () => onBack!(context, ref) : null,
      ),
      drawer: const AppDrawer(currentPage: Routes.map),
      body: SlidingUpPanel(
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
      ),
    );
  }
}
