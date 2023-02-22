import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:traveltime/screens/map/map_markers_navbar.dart';
import 'package:traveltime/screens/map/markers.dart';
import 'package:traveltime/providers/point_overview.dart';
import 'package:traveltime/screens/map/overview.dart';
import 'package:traveltime/widgets/stateful_wrapper.dart';

class MapScreenPanel extends ConsumerWidget {
  const MapScreenPanel({super.key, this.sc, this.pc, this.mc});

  final ScrollController? sc;
  final PanelController? pc;
  final MapController? mc;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final overview = ref.watch(overviewProvider);
    return MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: Stack(
          alignment: AlignmentDirectional.topCenter,
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(1.0, 0.0),
                    end: Offset.zero,
                  ).animate(animation),
                  child: child,
                );
              },
              child: overview == null
                  ? Container()
                  : StatefulWrapper(
                      onInit: () {
                        pc?.open();
                        mc?.fitBounds(overview.point.bounds);
                      },
                      onUpdate: () {
                        pc?.open();
                        mc?.fitBounds(overview.point.bounds);
                      },
                      child: Overview(sc: sc, id: overview.point.isarId),
                    ),
            ),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(-1.0, 0.0),
                    end: Offset.zero,
                  ).animate(animation),
                  child: child,
                );
              },
              child: overview == null
                  ? Column(
                      children: [
                        const SizedBox(height: 15),
                        const MapMarkersNavbar(),
                        Expanded(child: Markers(sc: sc)),
                      ],
                    )
                  : Container(),
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
