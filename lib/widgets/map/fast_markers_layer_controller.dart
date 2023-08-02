import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:traveltime/providers/map_tap_position.dart';
import 'package:traveltime/providers/overview/overview.dart';
import 'package:traveltime/widgets/map/fast_cluster.dart';
import 'package:traveltime/widgets/map/fast_marker.dart';
import 'package:traveltime/widgets/map/fast_markers_painter.dart';

class FastMarkersLayerController extends ConsumerStatefulWidget {
  const FastMarkersLayerController({
    super.key,
    required this.markers,
    required this.mapState,
    this.clusterTap,
    this.clusterDraw,
    this.clusterWidth,
    this.clusterHeight,
  });

  final List<FastMarker> markers;
  final FlutterMapState mapState;
  final void Function(Bounds bounds, FastCluster cluster)? clusterTap;
  final void Function(Canvas canvas, Offset offset, FastCluster cluster)?
      clusterDraw;
  final double? clusterWidth;
  final double? clusterHeight;

  @override
  ConsumerState<FastMarkersLayerController> createState() =>
      FastMarkersLayerControllerState();
}

class FastMarkersLayerControllerState
    extends ConsumerState<FastMarkersLayerController> {
  late FastMarkersPainter _painter;

  @override
  void initState() {
    _painter = FastMarkersPainter(
      markers: widget.markers,
      mapState: widget.mapState,
      clusterTap: widget.clusterTap,
      clusterDraw: widget.clusterDraw,
      clusterWidth: widget.clusterWidth,
      clusterHeight: widget.clusterHeight,
    );
    super.initState();
  }

  @override
  void didUpdateWidget(covariant FastMarkersLayerController oldWidget) {
    _painter = FastMarkersPainter(
      markers: widget.markers,
      mapState: widget.mapState,
      clusterTap: widget.clusterTap,
      clusterDraw: widget.clusterDraw,
      clusterWidth: widget.clusterWidth,
      clusterHeight: widget.clusterHeight,
    );
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    ref.invalidate(overviewProvider);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(mapTapPositionProvider, (previous, next) {
      _painter.onTap(next.offset);
    });

    return CustomPaint(
      painter: _painter,
      willChange: true,
    );
  }
}
