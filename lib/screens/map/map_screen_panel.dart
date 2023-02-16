import 'package:flutter/material.dart';
// import 'package:flutter_map/plugin_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:traveltime/screens/map/markers.dart';
import 'package:traveltime/screens/map/overview_provider.dart';
import 'package:traveltime/widgets/navbar/navbar_categories.dart';
import 'package:traveltime/screens/map/overview.dart';
import 'package:traveltime/widgets/stateful_wrapper.dart';

class MapScreenPanel extends ConsumerWidget {
  const MapScreenPanel({super.key, this.sc, this.pc});

  final ScrollController? sc;
  final PanelController? pc;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pointId = ref.watch(overviewProvider);
    // final mapState = FlutterMapState.maybeOf(context)!;
    // mapState.centerZoomFitBounds(LatLngBounds(), options)

    return MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: Stack(
          alignment: AlignmentDirectional.topCenter,
          children: [
            if (pointId == null)
              Column(
                children: [
                  const SizedBox(height: 15),
                  const NavbarCategories(),
                  Expanded(child: Markers(sc: sc)),
                ],
              ),
            if (pointId != null)
              StatefulWrapper(
                onInit: () {
                  pc?.open();
                },
                onUpdate: () {
                  pc?.open();
                },
                child: Overview(sc: sc, id: pointId),
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
