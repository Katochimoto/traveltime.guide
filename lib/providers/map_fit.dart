import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MapFitData {
  const MapFitData({required this.bounds});
  final LatLngBounds bounds;
}

class MapFitController extends Notifier<MapFitData?> {
  @override
  MapFitData? build() {
    return null;
  }

  void fitBounds(MapFitData data) {
    state = data;
  }
}

final mapFitProvider = NotifierProvider<MapFitController, MapFitData?>(() {
  return MapFitController();
});
