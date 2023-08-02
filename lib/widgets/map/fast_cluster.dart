import 'package:flutter_map/plugin_api.dart';
import 'package:latlong2/latlong.dart';
import 'package:traveltime/widgets/map/fast_marker.dart';

class FastCluster {
  LatLng? point;
  Bounds<double>? bounds;
  List<FastMarker>? markers;

  FastCluster({
    this.point,
    this.bounds,
    this.markers,
  });
}
