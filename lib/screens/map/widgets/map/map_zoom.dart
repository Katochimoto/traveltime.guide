import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:traveltime/providers/map_fit.dart';
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
        maxZoom: 18,
        forceIntegerZoomLevel: true,
        padding: EdgeInsets.only(
          left: 40,
          right: 40,
          top: 100,
          bottom: 150,
        ),
      ),
    );
    // to force upload tiles
    widget.mc.rotate(0.001);
    widget.mc.rotate(0.0);
  }

  @override
  Widget build(BuildContext context) {
    // if (ref.read(overviewProvider) != null) {
    //   return;
    // }

    ref.listenManual(mapObjectsFiltersProvider, (previous, next) {
      _zoomCompleter = Completer()..future.whenComplete(_fitBounds);
    }, fireImmediately: true);

    ref.listenManual(pointsProvider.future, (previous, next) async {
      final points = await next;
      _bounds =
          LatLngBounds.fromPoints(points.map((e) => e.coordinates).toList());
      _zoomCompleter?.complete();
    }, fireImmediately: true);

    ref.listen(mapFitProvider, (previous, next) {
      if (next != null) {
        _zoomCompleter = null;
        _bounds = next.bounds;
        _fitBounds();
      }
    });

    return const SizedBox.shrink();
  }
}
