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
import 'package:traveltime/screens/map/marks.dart';
import 'package:traveltime/screens/map/overview.dart';
import 'package:traveltime/widgets/map/attribution.dart';
import 'package:traveltime/widgets/map/draw_cluster.dart';
import 'package:traveltime/widgets/map/draw_text.dart';
import 'package:traveltime/widgets/map/fast_markers.dart';
import 'package:traveltime/widgets/map/popover.dart';
import 'package:traveltime/widgets/navbar/navbar.dart';
import 'package:traveltime/widgets/drawer/drawer.dart';
import 'package:traveltime/widgets/navbar/navbar_categories.dart';

const markerSize = 20.0;
const clusterSize = 40.0;

final markerFillPaint = Paint()
  ..color = Colors.white
  ..style = PaintingStyle.fill;

final markerStrokePaint = Paint()
  ..color = Colors.teal
  ..style = PaintingStyle.stroke
  ..strokeWidth = 2
  ..strokeCap = StrokeCap.round;

final arrowPaint = Paint()
  ..strokeWidth = 2.0
  ..color = Colors.teal
  ..style = PaintingStyle.fill;

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
    final tapStream = StreamController<Offset?>();
    return Stack(alignment: Alignment.topCenter, children: [
      FlutterMap(
        options: MapOptions(
          center: ll.LatLng(51.5, -0.09),
          zoom: 3,
          maxZoom: 17,
          minZoom: 3,
          interactiveFlags: InteractiveFlag.all & ~InteractiveFlag.rotate,
          onTap: (tapPosition, point) {
            ref.read(popoverPositionProvider.notifier).hide();
            tapStream.add(tapPosition.global);
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
                point: ll.LatLng(51.5, -0.09),
                width: markerSize,
                height: markerSize,
                anchorPos: AnchorPos.align(AnchorAlign.center),
                onDraw: _markerDraw,
                onTap: (bounds, point) {
                  ref
                      .read(popoverPositionProvider.notifier)
                      .updatePosition(Position(bounds: bounds, point: point));
                },
              ),
              FastMarker(
                point: ll.LatLng(12.910540799939268, 100.8561218137046),
                width: markerSize,
                height: markerSize,
                anchorPos: AnchorPos.align(AnchorAlign.center),
                onDraw: _markerDraw,
                onTap: (bounds, point) {
                  ref
                      .read(popoverPositionProvider.notifier)
                      .updatePosition(Position(bounds: bounds, point: point));
                },
              ),
              FastMarker(
                point: ll.LatLng(55.5, -0.09),
                width: clusterSize,
                height: clusterSize,
                anchorPos: AnchorPos.align(AnchorAlign.center),
                onDraw: _clusterDraw,
                onTap: (bounds, point) {
                  ref
                      .read(popoverPositionProvider.notifier)
                      .updatePosition(Position(bounds: bounds, point: point));
                },
              ),
            ],
          ),
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

  _clusterDraw(Canvas canvas, Offset offset) {
    final center = offset +
        const Offset(
          clusterSize / 2,
          clusterSize / 2,
        );

    canvas.drawCircle(
      center,
      clusterSize / 2,
      markerFillPaint,
    );

    DrawCluster.draw(
      canvas,
      center: center,
      radius: clusterSize / 2,
      sources: [10, 20, 16],
      colors: [Colors.blue, Colors.yellow, Colors.green],
      paintWidth: 5,
      startAngle: 0.0,
    );

    DrawText.draw(
      canvas: canvas,
      text: '10',
      offset: offset,
      size: clusterSize,
    );
  }

  _markerDraw(Canvas canvas, Offset offset) {
    final center = offset +
        const Offset(
          markerSize / 2,
          markerSize / 2,
        );

    const arrowWidth = 15.0;
    const arrowHeight = 10.0;
    const contentOffset = Offset(0, arrowHeight / 2 + markerSize / 2);
    final contentCenter = center - contentOffset;
    final path = Path()
      ..moveTo(center.dx + 0.0, center.dy + 0.0)
      ..lineTo(center.dx - arrowWidth * 0.5, center.dy - arrowHeight)
      ..lineTo(center.dx + arrowWidth * 0.5, center.dy - arrowHeight);

    canvas.drawPath(path, arrowPaint);

    canvas.drawCircle(
      contentCenter,
      markerSize / 2,
      markerFillPaint,
    );

    canvas.drawCircle(
      contentCenter,
      markerSize / 2,
      markerStrokePaint,
    );

    DrawText.draw(
      canvas: canvas,
      text: '🎡',
      offset: offset - contentOffset,
      size: markerSize,
      // paragraphWidth: markerSize * 0.5,
      fontSize: markerSize * 0.5,
    );
  }
}
