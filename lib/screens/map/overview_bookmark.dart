import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:traveltime/providers/bookmarks.dart';
import 'package:traveltime/store/db.dart';
import 'package:traveltime/store/models/point.dart';

class OverviewBookmark extends ConsumerWidget {
  const OverviewBookmark({super.key, required this.point});

  final Point point;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookmark = ref.watch(pointBookmarkProvider(point.id)).value;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: bookmark == null
              ? const Icon(Icons.bookmark_add)
              : const Icon(Icons.bookmark_remove),
          onPressed: () async {
            final bookmarks = ref.read(bookmarksProvider.notifier);
            if (bookmark == null) {
              await bookmarks.addPoint(point);
            } else {
              await bookmarks.removePoint(point);
            }
          },
          iconSize: 25,
          color: bookmark == null
              ? Colors.white70
              : Colors.tealAccent.withOpacity(0.7),
        ),
        Text('Bookmark',
            style: Theme.of(context)
                .textTheme
                .merge(Typography.whiteCupertino)
                .bodySmall)
      ],
    );
  }
}
