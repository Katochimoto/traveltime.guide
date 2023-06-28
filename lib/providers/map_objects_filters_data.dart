import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:traveltime/store/models/point.dart';

part 'map_objects_filters_data.g.dart';

@CopyWith()
class MapObjectsFiltersData {
  final List<PointCategory> categories;
  final bool bookmarks;
  final bool routes;

  const MapObjectsFiltersData({
    this.categories = const [],
    this.bookmarks = false,
    this.routes = false,
  });

  MapObjectsFiltersData toggleCategory(PointCategory data) {
    final next = [...categories];
    if (next.contains(data)) {
      next.remove(data);
    } else {
      next.add(data);
    }
    return copyWith.categories(next);
  }

  MapObjectsFiltersData toggleBookmarks({bool? toggle}) {
    return copyWith.bookmarks(toggle ?? !bookmarks);
  }

  MapObjectsFiltersData toggleRoutes({bool? toggle}) {
    return copyWith.routes(toggle ?? !routes);
  }
}
