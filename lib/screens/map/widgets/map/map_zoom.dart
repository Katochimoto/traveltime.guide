import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:traveltime/providers/map_objects_filters.dart';
import 'package:traveltime/store/db.dart';

class MapZoom extends ConsumerStatefulWidget {
  const MapZoom({super.key, required this.mc});

  final MapController mc;

  @override
  ConsumerState<MapZoom> createState() => MapZoomState();
}

class MapZoomState extends ConsumerState<MapZoom> {
  Completer? _zoomCompleter;
  LatLngBounds? _bounds;

  _fitBounds() {
    widget.mc.fitBounds(
      _bounds!,
      options: const FitBoundsOptions(
        padding: EdgeInsets.symmetric(
          vertical: 100,
          horizontal: 40,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // if (ref.read(overviewProvider) != null) {
    //   return;
    // }

    ref.listen(mapObjectsFiltersProvider, (previous, next) {
      _zoomCompleter = Completer()..future.whenComplete(_fitBounds);
    });

    ref.listenManual(pointsProvider.future, (previous, next) async {
      final points = await next;
      _bounds =
          LatLngBounds.fromPoints(points.map((e) => e.coordinates).toList());
      _zoomCompleter?.complete();
    }, fireImmediately: true);

    return const SizedBox.shrink();
  }
}
