import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:traveltime/store/models/point.dart';

class PointsFiltersData {
  final List<PointCategory> categories;
  final bool bookmarks;

  const PointsFiltersData({
    this.categories = const [],
    this.bookmarks = false,
  });

  PointsFiltersData toggleCategory(PointCategory data) {
    final next = [...categories];
    if (next.contains(data)) {
      next.remove(data);
    } else {
      next.add(data);
    }
    return PointsFiltersData(
      categories: next,
      bookmarks: bookmarks,
    );
  }

  PointsFiltersData toggleBookmarks({bool? toggle}) {
    return PointsFiltersData(
      categories: categories,
      bookmarks: toggle ?? !bookmarks,
    );
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

  void toggleBookmarks({bool? toggle}) {
    state = state.toggleBookmarks(toggle: toggle);
  }
}

final pointsFiltersProvider =
    NotifierProvider<PointsFiltersController, PointsFiltersData>(() {
  return PointsFiltersController();
});
