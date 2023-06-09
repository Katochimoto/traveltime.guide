import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:traveltime/providers/map_tap_position.dart';

/// A polyline with a tag
class TaggedPolyline extends Polyline {
  /// The name of the polyline
  final String? tag;

  final List<Offset> _offsets = [];

  TaggedPolyline({
    required super.points,
    super.strokeWidth = 1.0,
    super.color = const Color(0xFF00FF00),
    super.borderStrokeWidth = 0.0,
    super.borderColor = const Color(0xFFFFFF00),
    super.gradientColors,
    super.colorsStop,
    super.isDotted = false,
    this.tag,
  });
}

class TappablePolylineLayerController extends ConsumerWidget {
  const TappablePolylineLayerController({
    super.key,
    required this.polylines,
    this.onTap,
    this.onMiss,
    this.pointerDistanceTolerance = 15,
  });

  final List<TaggedPolyline> polylines;
  final void Function(List<TaggedPolyline>, Offset offset)? onTap;
  final void Function(Offset offset)? onMiss;
  final double? pointerDistanceTolerance;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mapState = FlutterMapState.maybeOf(context)!;
    ref.listen(mapTapPositionProvider, (previous, next) {
      _handlePolylineTap(next.offset!);
    });

    return Stack(
      children: [
        CustomPaint(
          painter: PolylinePainter(polylines, mapState),
        ),
      ],
    );
  }

  void _handlePolylineTap(Offset tap) {
    // We might hit close to multiple polylines. We will therefore keep a reference to these in this map.
    Map<double, List<TaggedPolyline>> candidates = {};

    // Calculating taps in between points on the polyline. We
    // iterate over all the segments in the polyline to find any
    // matches with the tapped point within the
    // pointerDistanceTolerance.
    for (TaggedPolyline currentPolyline in polylines) {
      for (var j = 0; j < currentPolyline._offsets.length - 1; j++) {
        // We consider the points point1, point2 and tap points in a triangle
        var point1 = currentPolyline._offsets[j];
        var point2 = currentPolyline._offsets[j + 1];

        // To determine if we have tapped in between two po ints, we
        // calculate the length from the tapped point to the line
        // created by point1, point2. If this distance is shorter
        // than the specified threshold, we have detected a tap
        // between two points.
        //
        // We start by calculating the length of all the sides using pythagoras.
        var a = _distance(point1, point2);
        var b = _distance(point1, tap);
        var c = _distance(point2, tap);

        // To find the height when we only know the lengths of the sides, we can use Herons formula to get the Area.
        var semiPerimeter = (a + b + c) / 2.0;
        var triangleArea = sqrt(semiPerimeter *
            (semiPerimeter - a) *
            (semiPerimeter - b) *
            (semiPerimeter - c));

        // We can then finally calculate the length from the tapped point onto the line created by point1, point2.
        // Area of triangles is half the area of a rectangle
        // area = 1/2 base * height -> height = (2 * area) / base
        var height = (2 * triangleArea) / a;

        // We're not there yet - We need to satisfy the edge case
        // where the perpendicular line from the tapped point onto
        // the line created by point1, point2 (called point D) is
        // outside of the segment point1, point2. We need
        // to check if the length from D to the original segment
        // (point1, point2) is less than the threshold.

        var hypotenus = max(b, c);
        var newTriangleBase = sqrt((hypotenus * hypotenus) - (height * height));
        var lengthDToOriginalSegment = newTriangleBase - a;

        if (height < pointerDistanceTolerance! &&
            lengthDToOriginalSegment < pointerDistanceTolerance!) {
          var minimum = min(height, lengthDToOriginalSegment);

          candidates[minimum] ??= <TaggedPolyline>[];
          candidates[minimum]!.add(currentPolyline);
        }
      }
    }

    if (candidates.isEmpty) {
      onMiss?.call(tap);
    } else {
      // We look up in the map of distances to the tap, and choose the shortest one.
      var closestToTapKey = candidates.keys.reduce(min);
      onTap!(candidates[closestToTapKey]!, tap);
    }
  }

  double _distance(Offset point1, Offset point2) {
    final distancex = (point1.dx - point2.dx).abs();
    final distancey = (point1.dy - point2.dy).abs();
    final distance = sqrt((distancex * distancex) + (distancey * distancey));
    return distance;
  }
}

class TappablePolylineLayer extends PolylineLayer {
  const TappablePolylineLayer({
    this.polylines = const [],
    this.onTap,
    this.onMiss,
    this.pointerDistanceTolerance,
    super.polylineCulling = false,
    super.key,
  });

  /// The list of [TaggedPolyline] which could be tapped
  @override
  final List<TaggedPolyline> polylines;

  /// The tolerated distance between pointer and user tap to trigger the [onTap] callback
  final double? pointerDistanceTolerance;

  final void Function(List<TaggedPolyline>, Offset offset)? onTap;
  final void Function(Offset offset)? onMiss;

  @override
  Widget build(BuildContext context) {
    final mapState = FlutterMapState.maybeOf(context)!;
    final lines = polylineCulling
        ? polylines
            .where((p) => p.boundingBox.isOverlapping(mapState.bounds))
            .toList()
        : polylines;

    for (TaggedPolyline polyline in lines) {
      polyline._offsets.clear();
      var i = 0;
      for (var point in polyline.points) {
        var pos = mapState.project(point);
        pos = (pos * mapState.getZoomScale(mapState.zoom, mapState.zoom)) -
            mapState.pixelOrigin;
        polyline._offsets.add(Offset(pos.x.toDouble(), pos.y.toDouble()));
        if (i > 0 && i < polyline.points.length) {
          polyline._offsets.add(Offset(pos.x.toDouble(), pos.y.toDouble()));
        }
        i++;
      }
    }

    return TappablePolylineLayerController(
      polylines: lines,
      onMiss: onMiss,
      onTap: onTap,
      pointerDistanceTolerance: pointerDistanceTolerance,
    );
  }
}
