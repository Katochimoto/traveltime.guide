import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:traveltime/providers/map_objects_filters.dart';
import 'package:traveltime/screens/map/consts.dart';
import 'package:traveltime/store/db.dart';
import 'package:traveltime/store/models/point.dart';
import 'package:traveltime/widgets/navbar/navbar_categories.dart';

class MapMarkersNavbar extends ConsumerWidget {
  const MapMarkersNavbar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loc = AppLocalizations.of(context)!;
    final filters = ref.watch(mapObjectsFiltersProvider);
    final points = ref.watch(pointsCategoriesProvider).value ?? [];

    return NavbarCategories(
      items: [
        NavbarCategorieButton(
          icon: Icons.bookmarks,
          title: loc.bookmarks,
          selected: filters.bookmarks,
          onPressed: () {
            ref.read(mapObjectsFiltersProvider.notifier).toggleBookmarks();
          },
        ),
        NavbarCategorieButton(
          icon: Icons.route,
          title: loc.routes,
          selected: filters.routes,
          onPressed: () {
            ref.read(mapObjectsFiltersProvider.notifier).toggleRoutes();
          },
        ),
        for (final point in points)
          NavbarCategorieButton(
            icon: markerIcons[point.category] ?? defaultMarkerIcon,
            title: localizedCategory(point.category, context),
            selected: filters.categories.contains(point.category),
            onPressed: () {
              ref
                  .read(mapObjectsFiltersProvider.notifier)
                  .toggleCategory(point.category);
            },
          ),
      ],
    );
  }

  String localizedCategory(PointCategory category, BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    switch (category) {
      case PointCategory.entertainment:
        return loc.pointCategoryEntertainment;
      case PointCategory.event:
        return loc.pointCategoryEvents;
      case PointCategory.attraction:
        return loc.pointCategoryAttraction;
      case PointCategory.nightMarket:
        return loc.pointCategoryNightMarket;
      case PointCategory.hypermarket:
        return loc.pointCategoryHypermarket;
      case PointCategory.beach:
        return loc.pointCategoryBeach;
      case PointCategory.restaurant:
        return loc.pointCategoryRestaurant;
      case PointCategory.cafe:
        return loc.pointCategoryCafe;
      case PointCategory.marina:
        return loc.pointCategoryMarina;
      case PointCategory.police:
        return loc.pointCategoryPolice;
      case PointCategory.gasStation:
        return loc.pointCategoryGasStation;
      case PointCategory.carRental:
        return loc.pointCategoryCarRental;
      case PointCategory.hotel:
        return loc.pointCategoryHotel;
    }
  }
}
