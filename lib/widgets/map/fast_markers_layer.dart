import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:traveltime/widgets/map/fast_cluster.dart';
import 'package:traveltime/widgets/map/fast_marker.dart';
import 'package:traveltime/widgets/map/fast_markers_layer_controller.dart';

class FastMarkersLayer extends StatelessWidget {
  const FastMarkersLayer({
    super.key,
    required this.markers,
    this.clusterTap,
    this.clusterDraw,
    this.clusterWidth,
    this.clusterHeight,
  });

  final List<FastMarker> markers;
  final void Function(Bounds bounds, FastCluster cluster)? clusterTap;
  final void Function(Canvas canvas, Offset offset, FastCluster cluster)?
      clusterDraw;
  final double? clusterWidth;
  final double? clusterHeight;

  @override
  Widget build(BuildContext context) {
    final mapState = FlutterMapState.of(context);
    return FastMarkersLayerController(
      markers: markers,
      mapState: mapState,
      clusterTap: clusterTap,
      clusterDraw: clusterDraw,
      clusterWidth: clusterWidth,
      clusterHeight: clusterHeight,
    );
  }
}
