import 'package:flutter_riverpod/flutter_riverpod.dart';

class _MapCurrentLocation extends StateNotifier<double?> {
  _MapCurrentLocation() : super(null);

  void zoom() {
    state = 16;
  }
}

final mapCurrentLocationProvider =
    StateNotifierProvider<_MapCurrentLocation, double?>((ref) {
  return _MapCurrentLocation();
});
