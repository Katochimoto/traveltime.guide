// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'map_objects_filters_data.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$MapObjectsFiltersDataCWProxy {
  MapObjectsFiltersData categories(List<PointCategory> categories);

  MapObjectsFiltersData bookmarks(bool bookmarks);

  MapObjectsFiltersData routes(bool routes);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `MapObjectsFiltersData(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// MapObjectsFiltersData(...).copyWith(id: 12, name: "My name")
  /// ````
  MapObjectsFiltersData call({
    List<PointCategory>? categories,
    bool? bookmarks,
    bool? routes,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfMapObjectsFiltersData.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfMapObjectsFiltersData.copyWith.fieldName(...)`
class _$MapObjectsFiltersDataCWProxyImpl
    implements _$MapObjectsFiltersDataCWProxy {
  const _$MapObjectsFiltersDataCWProxyImpl(this._value);

  final MapObjectsFiltersData _value;

  @override
  MapObjectsFiltersData categories(List<PointCategory> categories) =>
      this(categories: categories);

  @override
  MapObjectsFiltersData bookmarks(bool bookmarks) => this(bookmarks: bookmarks);

  @override
  MapObjectsFiltersData routes(bool routes) => this(routes: routes);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `MapObjectsFiltersData(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// MapObjectsFiltersData(...).copyWith(id: 12, name: "My name")
  /// ````
  MapObjectsFiltersData call({
    Object? categories = const $CopyWithPlaceholder(),
    Object? bookmarks = const $CopyWithPlaceholder(),
    Object? routes = const $CopyWithPlaceholder(),
  }) {
    return MapObjectsFiltersData(
      categories:
          categories == const $CopyWithPlaceholder() || categories == null
              ? _value.categories
              // ignore: cast_nullable_to_non_nullable
              : categories as List<PointCategory>,
      bookmarks: bookmarks == const $CopyWithPlaceholder() || bookmarks == null
          ? _value.bookmarks
          // ignore: cast_nullable_to_non_nullable
          : bookmarks as bool,
      routes: routes == const $CopyWithPlaceholder() || routes == null
          ? _value.routes
          // ignore: cast_nullable_to_non_nullable
          : routes as bool,
    );
  }
}

extension $MapObjectsFiltersDataCopyWith on MapObjectsFiltersData {
  /// Returns a callable class that can be used as follows: `instanceOfMapObjectsFiltersData.copyWith(...)` or like so:`instanceOfMapObjectsFiltersData.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$MapObjectsFiltersDataCWProxy get copyWith =>
      _$MapObjectsFiltersDataCWProxyImpl(this);
}
