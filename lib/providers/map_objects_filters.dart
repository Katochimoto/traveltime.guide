import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:traveltime/providers/map_objects_filters_data.dart';
import 'package:traveltime/store/models/point.dart';

class MapObjectsFiltersController extends Notifier<MapObjectsFiltersData> {
  @override
  MapObjectsFiltersData build() {
    return const MapObjectsFiltersData();
  }

  void toggleCategory(PointCategory data) {
    state = state.toggleCategory(data);
  }

  void toggleBookmarks({bool? toggle}) {
    state = state.toggleBookmarks(toggle: toggle);
  }

  void toggleRoutes({bool? toggle}) {
    state = state.toggleRoutes(toggle: toggle);
  }
}

final mapObjectsFiltersProvider =
    NotifierProvider<MapObjectsFiltersController, MapObjectsFiltersData>(() {
  return MapObjectsFiltersController();
});
