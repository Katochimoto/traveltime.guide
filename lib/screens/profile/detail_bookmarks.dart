import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:traveltime/constants/routes.dart';
import 'package:traveltime/providers/points_filters.dart';

class DetailBookmarks extends ConsumerWidget {
  const DetailBookmarks({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(Icons.bookmarks),
          onPressed: () {
            ref
                .read(pointsFiltersProvider.notifier)
                .toggleBookmarks(toggle: true);
            context.pushNamed(Routes.map);
          },
          iconSize: 25,
          color: Colors.white,
        ),
        Text('Bookmarks',
            style: Theme.of(context)
                .textTheme
                .merge(Typography.whiteCupertino)
                .bodySmall)
      ],
    );
  }
}
