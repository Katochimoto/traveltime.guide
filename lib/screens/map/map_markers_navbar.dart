import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:traveltime/providers/points_filters.dart';
import 'package:traveltime/screens/map/consts.dart';
import 'package:traveltime/store/db.dart';
import 'package:traveltime/widgets/navbar/navbar_categories.dart';

class MapMarkersNavbar extends ConsumerWidget {
  const MapMarkersNavbar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filters = ref.watch(pointsFiltersProvider);
    final points = ref.watch(pointsCategoriesProvider).value ?? [];

    return NavbarCategories(
      items: [
        for (final point in points)
          NavbarCategorieButton(
            icon: markerIcons[point.category] ?? defaultMarkerIcon,
            title: point.category.name,
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
}
