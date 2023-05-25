import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:traveltime/providers/app_auth.dart';
import 'package:traveltime/providers/bookmarks.dart';
import 'package:traveltime/providers/points_filters.dart';
import 'package:traveltime/store/models/article.dart';
import 'package:traveltime/store/models/event.dart';
import 'package:traveltime/store/models/point.dart';
import 'package:traveltime/store/models/route.dart';
import 'package:traveltime/store/models/route_leg.dart';
import 'package:traveltime/store/models/route_waypoint.dart';
import 'package:traveltime/store/models/user_bookmark.dart';

class Db extends AsyncNotifier<Isar> {
  @override
  Future<Isar> build() async {
    // @todo add auth user id
    const name = r'traveltime';

    var db = Isar.getInstance(name);
    if (db == null || !db.isOpen) {
      final dir = await getApplicationSupportDirectory();
      db = await Isar.open(
        [
          ArticleSchema,
          PointSchema,
          UserBookmarkSchema,
          EventSchema,
          RouteSchema,
          RouteWaypointSchema,
          RouteLegSchema,
        ],
        name: name,
        directory: dir.path,
        inspector: true,
      );
    }

    return db;
  }
}

final dbProvider = AsyncNotifierProvider<Db, Isar>(() {
  return Db();
});

final articlesProvider = StreamProvider.autoDispose((ref) async* {
  final locale =
      await ref.watch(appAuthProvider.selectAsync((data) => data.locale));
  final db = await ref.watch(dbProvider.future);
  final query = db
      .collection<Article>()
      .filter()
      .localeEqualTo(locale)
      .sortByPublishedAtDesc()
      .build();

  await for (final results in query.watch(fireImmediately: true)) {
    if (results.isNotEmpty) {
      yield results;
    }
  }
});

final articleProvider =
    StreamProvider.autoDispose.family<Article?, int>((ref, id) async* {
  final db = await ref.watch(dbProvider.future);
  final data = db.collection<Article>().watchObject(id, fireImmediately: true);
  await for (final results in data) {
    yield results;
  }
});

final pointsProvider = StreamProvider.autoDispose((ref) async* {
  await ref.watch(bookmarksProvider.future);
  final filters = ref.watch(pointsFiltersProvider);
  final locale =
      await ref.watch(appAuthProvider.selectAsync((data) => data.locale));
  final db = await ref.watch(dbProvider.future);

  var query = db
      .collection<Point>()
      .filter()
      .localeEqualTo(locale)
      .anyOf(filters.categories, (q, value) => q.categoryEqualTo(value));

  if (filters.bookmarks) {
    final bookmarks = await db
        .collection<UserBookmark>()
        .filter()
        .typeEqualTo(UserBookmarkType.point)
        .findAll();
    final bookmarkIds =
        bookmarks.map((item) => item.objectId).toList(growable: false);
    query = query.anyOf(bookmarkIds, (q, value) => q.idEqualTo(value));
  }

  final buildQuery = query.sortByPublishedAtDesc().build();

  await for (final results in buildQuery.watch(fireImmediately: true)) {
    if (results.isNotEmpty) {
      yield results;
    }
  }
});

final pointProvider =
    StreamProvider.autoDispose.family<Point?, int>((ref, id) async* {
  final db = await ref.watch(dbProvider.future);
  final data = db.collection<Point>().watchObject(id, fireImmediately: true);
  await for (final results in data) {
    yield results;
  }
});

final pointBookmarkProvider =
    StreamProvider.autoDispose.family<UserBookmark?, String>((ref, id) async* {
  final db = await ref.watch(dbProvider.future);
  final query = db
      .collection<UserBookmark>()
      .filter()
      .typeEqualTo(UserBookmarkType.point)
      .objectIdEqualTo(id)
      .build();

  await for (final results in query.watch(fireImmediately: true)) {
    if (results.isNotEmpty) {
      yield results.first;
    } else {
      yield null;
    }
  }
});

final pointsCategoriesProvider = StreamProvider.autoDispose((ref) async* {
  final locale =
      await ref.watch(appAuthProvider.selectAsync((data) => data.locale));
  final db = await ref.watch(dbProvider.future);

  final query = db
      .collection<Point>()
      .filter()
      .localeEqualTo(locale)
      .distinctByCategory()
      .build();

  await for (final results in query.watch(fireImmediately: true)) {
    if (results.isNotEmpty) {
      yield results;
    }
  }
});

final eventsProvider = StreamProvider.autoDispose((ref) async* {
  final locale =
      await ref.watch(appAuthProvider.selectAsync((data) => data.locale));
  final db = await ref.watch(dbProvider.future);
  final query = db
      .collection<Event>()
      .filter()
      .localeEqualTo(locale)
      .sortByPublishedAtDesc()
      .build();

  await for (final results in query.watch(fireImmediately: true)) {
    if (results.isNotEmpty) {
      yield results;
    }
  }
});

final eventProvider =
    StreamProvider.autoDispose.family<Event?, int>((ref, id) async* {
  final db = await ref.watch(dbProvider.future);
  final data = db.collection<Event>().watchObject(id, fireImmediately: true);
  await for (final results in data) {
    yield results;
  }
});

final eventPointsProvider =
    StreamProvider.autoDispose.family<List<Point>, Event>((ref, event) async* {
  if (event.points.isEmpty) {
    yield [];
  } else {
    final locale =
        await ref.watch(appAuthProvider.selectAsync((data) => data.locale));
    final db = await ref.watch(dbProvider.future);

    final query = db
        .collection<Point>()
        .filter()
        .localeEqualTo(locale)
        .anyOf(event.points, (q, value) => q.idEqualTo(value))
        .sortByPublishedAtDesc()
        .build();

    await for (final results in query.watch(fireImmediately: true)) {
      if (results.isNotEmpty) {
        yield results;
      }
    }
  }
});
