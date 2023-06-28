// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'points_filters_data.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$PointsFiltersDataCWProxy {
  PointsFiltersData categories(List<PointCategory> categories);

  PointsFiltersData bookmarks(bool bookmarks);

  PointsFiltersData routes(bool routes);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PointsFiltersData(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PointsFiltersData(...).copyWith(id: 12, name: "My name")
  /// ````
  PointsFiltersData call({
    List<PointCategory>? categories,
    bool? bookmarks,
    bool? routes,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfPointsFiltersData.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfPointsFiltersData.copyWith.fieldName(...)`
class _$PointsFiltersDataCWProxyImpl implements _$PointsFiltersDataCWProxy {
  const _$PointsFiltersDataCWProxyImpl(this._value);

  final PointsFiltersData _value;

  @override
  PointsFiltersData categories(List<PointCategory> categories) =>
      this(categories: categories);

  @override
  PointsFiltersData bookmarks(bool bookmarks) => this(bookmarks: bookmarks);

  @override
  PointsFiltersData routes(bool routes) => this(routes: routes);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PointsFiltersData(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PointsFiltersData(...).copyWith(id: 12, name: "My name")
  /// ````
  PointsFiltersData call({
    Object? categories = const $CopyWithPlaceholder(),
    Object? bookmarks = const $CopyWithPlaceholder(),
    Object? routes = const $CopyWithPlaceholder(),
  }) {
    return PointsFiltersData(
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

extension $PointsFiltersDataCopyWith on PointsFiltersData {
  /// Returns a callable class that can be used as follows: `instanceOfPointsFiltersData.copyWith(...)` or like so:`instanceOfPointsFiltersData.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$PointsFiltersDataCWProxy get copyWith =>
      _$PointsFiltersDataCWProxyImpl(this);
}
