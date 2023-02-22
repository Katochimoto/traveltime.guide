import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:traveltime/providers/points_filters.dart';
import 'package:traveltime/screens/map/consts.dart';
import 'package:traveltime/store/db.dart';
import 'package:traveltime/store/models/point.dart';
import 'package:traveltime/widgets/navbar/navbar_categories.dart';

class MapMarkersNavbar extends ConsumerWidget {
  const MapMarkersNavbar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filters = ref.watch(pointsFiltersProvider);
    final points = ref.watch(pointsCategoriesProvider).value ?? [];

    return NavbarCategories(
      items: [
        NavbarCategorieButton(
          icon: Icons.bookmarks,
          title: 'Bookmarks',
          selected: filters.bookmarks,
          onPressed: () {
            ref.read(pointsFiltersProvider.notifier).toggleBookmarks();
          },
        ),
        for (final point in points)
          NavbarCategorieButton(
            icon: markerIcons[point.category] ?? defaultMarkerIcon,
            title: localizedCategory(point.category, context),
            selected: filters.categories.contains(point.category),
            onPressed: () {
              ref
                  .read(pointsFiltersProvider.notifier)
                  .toggleCategory(point.category);
            },
          ),
      ],
    );
  }

  String localizedCategory(PointCategory category, BuildContext context) {
    switch (category) {
      case PointCategory.entertainment:
        return AppLocalizations.of(context)!.pointCategoryEntertainment;
      case PointCategory.events:
        return AppLocalizations.of(context)!.pointCategoryEvents;
      case PointCategory.attraction:
        return AppLocalizations.of(context)!.pointCategoryAttraction;
      case PointCategory.nightMarket:
        return AppLocalizations.of(context)!.pointCategoryNightMarket;
      case PointCategory.hypermarket:
        return AppLocalizations.of(context)!.pointCategoryHypermarket;
      case PointCategory.beach:
        return AppLocalizations.of(context)!.pointCategoryBeach;
      case PointCategory.restaurant:
        return AppLocalizations.of(context)!.pointCategoryRestaurant;
      case PointCategory.cafe:
        return AppLocalizations.of(context)!.pointCategoryCafe;
      case PointCategory.marina:
        return AppLocalizations.of(context)!.pointCategoryMarina;
      case PointCategory.police:
        return AppLocalizations.of(context)!.pointCategoryPolice;
      case PointCategory.gasStation:
        return AppLocalizations.of(context)!.pointCategoryGasStation;
      case PointCategory.carRental:
        return AppLocalizations.of(context)!.pointCategoryCarRental;
      case PointCategory.hotel:
        return AppLocalizations.of(context)!.pointCategoryHotel;
    }
  }
}
