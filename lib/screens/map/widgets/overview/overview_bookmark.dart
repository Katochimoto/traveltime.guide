import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:traveltime/providers/bookmarks.dart';
import 'package:traveltime/screens/map/widgets/overview/overview_button.dart';
import 'package:traveltime/store/db.dart';
import 'package:traveltime/store/models.dart' as models;

class OverviewBookmark extends ConsumerWidget {
  const OverviewBookmark({super.key, required this.point});

  final models.Point point;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookmark = ref.watch(pointBookmarkProvider(point.id)).value;
    return OverviewButton(
      title: 'Bookmark',
      active: bookmark != null,
      icon: bookmark == null ? Icons.bookmark_add : Icons.bookmark_remove,
      onPressed: () async {
        final bookmarks = ref.read(bookmarksProvider.notifier);
        if (bookmark == null) {
          await bookmarks.addPoint(point);
        } else {
          await bookmarks.removePoint(point);
        }
      },
    );
  }
}
