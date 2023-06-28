import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:traveltime/providers/points_filters_data.dart';
import 'package:traveltime/store/models/point.dart';

class PointsFiltersController extends Notifier<PointsFiltersData> {
  @override
  PointsFiltersData build() {
    return const PointsFiltersData();
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

final pointsFiltersProvider =
    NotifierProvider<PointsFiltersController, PointsFiltersData>(() {
  return PointsFiltersController();
});
