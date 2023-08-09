import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:traveltime/providers/map_fit.dart';
import 'package:traveltime/providers/map_objects_filters.dart';
import 'package:traveltime/providers/overview/overview.dart';
import 'package:traveltime/store/db.dart';
import 'package:traveltime/utils/debouncer.dart';

class MapZoom extends ConsumerStatefulWidget {
  const MapZoom({super.key, required this.mc});

  final MapController mc;

  @override
  ConsumerState<MapZoom> createState() => MapZoomState();
}

class MapZoomState extends ConsumerState<MapZoom> {
  Completer? _zoomCompleter;
  LatLngBounds? _bounds;
  final Debouncer _debouncer = Debouncer(milliseconds: 100);

  bool get hasOverview => ref.read(overviewProvider) != null;

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
  void dispose() {
    _debouncer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listenManual(mapObjectsFiltersProvider, (previous, next) {
      if (!hasOverview) {
        _zoomCompleter = Completer()
          ..future.whenComplete(() => _debouncer.run(_fitBounds));
      }
    }, fireImmediately: true);

    ref.listenManual(pointsProvider.future, (previous, next) async {
      if (!hasOverview) {
        final points = await next;
        _bounds =
            LatLngBounds.fromPoints(points.map((e) => e.coordinates).toList());
        _zoomCompleter?.complete();
      }
    }, fireImmediately: true);

    ref.listenManual(mapFitProvider, (previous, next) {
      if (next != null) {
        _zoomCompleter = null;
        _bounds = next.bounds;
        _debouncer.run(_fitBounds);
      }
    }, fireImmediately: true);

    return const SizedBox.shrink();
  }
}
