import 'package:flutter/material.dart';
import 'package:flutter_map_tappable_polyline/flutter_map_tappable_polyline.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';

class MapRoutes extends ConsumerWidget {
  const MapRoutes({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TappablePolylineLayer(
      polylineCulling: true,
      pointerDistanceTolerance: 20,
      polylines: [
        TaggedPolyline(
          tag: 'My Polyline',
          points: [
            LatLng(5.58213, 45.13065),
            LatLng(5.58209, 45.13078),
            LatLng(5.58186, 45.13091),
            LatLng(5.58184, 45.13099),
          ],
          color: Colors.red,
          strokeWidth: 9.0,
        ),
        TaggedPolyline(
          tag: 'My 2nd Polyline',
          points: [
            LatLng(5.58178, 45.13105),
            LatLng(5.5817, 45.13109),
            LatLng(5.58163, 45.1311),
            LatLng(5.58149, 45.13108),
          ],
          color: Colors.black,
          strokeWidth: 3.0,
        ),
        TaggedPolyline(
          tag: 'My 3rd Polyline',
          points: [
            LatLng(5.58141, 45.13103),
            LatLng(5.58138, 45.13099),
            LatLng(5.58136, 45.13093),
            LatLng(5.58125, 45.13084),
          ],
          color: Colors.blue,
          strokeWidth: 3.0,
        ),
      ],
      onTap: (polylines, tapPosition) => print('Tapped: ' +
          polylines.map((polyline) => polyline.tag).join(',') +
          ' at ' +
          tapPosition.globalPosition.toString()),
      onMiss: (tapPosition) {
        print('No polyline was tapped at position ' +
            tapPosition.globalPosition.toString());
      },
    );
  }
}