import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:traveltime/store/models/point.dart';

class PointsFiltersData {
  final List<PointCategory> categories;

  const PointsFiltersData({
    this.categories = const [],
  });

  PointsFiltersData toggleCategory(PointCategory data) {
    final next = [...categories];
    if (next.contains(data)) {
      next.remove(data);
    } else {
      next.add(data);
    }
    return PointsFiltersData(categories: next);
  }
}

class PointsFiltersController extends Notifier<PointsFiltersData> {
  @override
  PointsFiltersData build() {
    return const PointsFiltersData();
  }

  void toggleCategory(PointCategory data) {
    state = state.toggleCategory(data);
  }
}

final pointsFiltersProvider =
    NotifierProvider<PointsFiltersController, PointsFiltersData>(() {
  return PointsFiltersController();
});
