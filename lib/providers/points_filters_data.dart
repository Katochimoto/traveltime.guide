import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:traveltime/store/models/point.dart';

part 'points_filters_data.g.dart';

@CopyWith()
class PointsFiltersData {
  final List<PointCategory> categories;
  final bool bookmarks;
  final bool routes;

  const PointsFiltersData({
    this.categories = const [],
    this.bookmarks = false,
    this.routes = false,
  });

  PointsFiltersData toggleCategory(PointCategory data) {
    final next = [...categories];
    if (next.contains(data)) {
      next.remove(data);
    } else {
      next.add(data);
    }
    return copyWith.categories(next);
  }

  PointsFiltersData toggleBookmarks({bool? toggle}) {
    return copyWith.bookmarks(toggle ?? !bookmarks);
  }

  PointsFiltersData toggleRoutes({bool? toggle}) {
    return copyWith.routes(toggle ?? !routes);
  }
}
