import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong2/latlong.dart';
import 'package:traveltime/store/models/point.dart';
import 'package:traveltime/utils/hash.dart';

class FastMarker {
  final int id;
  final PointCategory category;
  final LatLng point;
  final double width;
  final double height;
  final Anchor anchor;
  final Function(Canvas canvas, Offset offset, FastMarker marker) onDraw;
  final Function(Bounds bounds, FastMarker marker)? onTap;

  FastMarker({
    required this.id,
    required this.category,
    required this.point,
    this.width = 30.0,
    this.height = 30.0,
    required this.onDraw,
    this.onTap,
    required AnchorPos anchorPos,
  }) : anchor = Anchor.fromPos(anchorPos, width, height);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! FastMarker) return false;
    FastMarker other0 = other;
    return id == other0.id &&
        category == other0.category &&
        point == other0.point &&
        width == other0.width &&
        height == other0.height &&
        anchor == other0.anchor &&
        onDraw == other0.onDraw &&
        onTap == other0.onTap;
  }

  @override
  int get hashCode {
    return hash([id, category, point, width, height, anchor, onDraw, onTap]);
  }
}
