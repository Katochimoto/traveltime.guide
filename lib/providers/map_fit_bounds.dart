import 'package:flutter_map/plugin_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:traveltime/providers/overview/overview.dart';
import 'package:traveltime/utils/debouncer.dart';

class MapFitBounds extends Notifier<LatLngBounds?> {
  final _debouncer = Debouncer(milliseconds: 100);
  LatLngBounds? _bounds;

  @override
  LatLngBounds? build() {
    return null;
  }

  void fitBounds(LatLngBounds data, {bool? force}) {
    if (ref.read(overviewProvider) != null) {
      return;
    }

    print('>>>>> $force');

    if (_bounds == null || force == true) {
      _bounds = data;
    } else {
      final bounds = LatLngBounds(state!.southEast, state!.northWest);
      bounds.extendBounds(data);
      _bounds = bounds;
    }

    _debouncer.run(() => _fitBounds());
  }

  void _fitBounds() {
    state = _bounds;
    _bounds = null;
  }
}

final mapFitBoundsProvider = NotifierProvider<MapFitBounds, LatLngBounds?>(() {
  return MapFitBounds();
});
