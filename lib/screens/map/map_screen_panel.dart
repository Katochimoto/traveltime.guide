import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:traveltime/providers/map_fit.dart';
import 'package:traveltime/screens/map/map_markers_navbar.dart';
import 'package:traveltime/screens/map/markers.dart';
import 'package:traveltime/providers/overview/overview.dart';
import 'package:traveltime/screens/map/widgets/overview/overview_point.dart';
import 'package:traveltime/screens/map/widgets/overview/overview_route.dart';
import 'package:traveltime/store/models.dart' as models;

class MapScreenPanel extends ConsumerStatefulWidget {
  const MapScreenPanel({
    super.key,
    required this.sc,
    required this.pc,
    required this.mc,
  });

  final ScrollController sc;
  final PanelController pc;
  final MapController mc;

  @override
  ConsumerState<MapScreenPanel> createState() => MapScreenPanelState();
}

class MapScreenPanelState extends ConsumerState<MapScreenPanel> {
  @override
  void initState() {
    ref.listenManual(
      overviewProvider,
      (previous, next) {
        if (next != null) {
          widget.pc.open();
          ref
              .read(mapFitProvider.notifier)
              .fitBounds(MapFitData(bounds: next.object.bounds));
        }
      },
      fireImmediately: true,
    );
    super.initState();
  }

  @override
  void dispose() {
    ref.invalidate(overviewProvider);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                  ? const SizedBox.shrink()
                  : overview.object is models.Point
                      ? OverviewPoint(sc: widget.sc, id: overview.object.isarId)
                      : OverviewRoute(
                          sc: widget.sc, id: overview.object.isarId),
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
                        Expanded(child: Markers(sc: widget.sc)),
                      ],
                    )
                  : const SizedBox.shrink(),
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
