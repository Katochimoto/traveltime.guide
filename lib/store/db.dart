import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:traveltime/providers/app_auth.dart';
import 'package:traveltime/providers/bookmarks.dart';
import 'package:traveltime/providers/points_filters.dart';
import 'models.dart' as models;

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
          models.ArticleSchema,
          models.PointSchema,
          models.UserBookmarkSchema,
          models.EventSchema,
          models.RouteSchema,
          models.RouteWaypointSchema,
          models.RouteLegSchema,
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
      .collection<models.Article>()
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
    StreamProvider.autoDispose.family<models.Article?, int>((ref, id) async* {
  final db = await ref.watch(dbProvider.future);
  final data =
      db.collection<models.Article>().watchObject(id, fireImmediately: true);
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
      .collection<models.Point>()
      .filter()
      .localeEqualTo(locale)
      .anyOf(filters.categories, (q, value) => q.categoryEqualTo(value));

  if (filters.bookmarks) {
    final bookmarks = await db
        .collection<models.UserBookmark>()
        .filter()
        .typeEqualTo(models.UserBookmarkType.point)
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
    StreamProvider.autoDispose.family<models.Point?, int>((ref, id) async* {
  final db = await ref.watch(dbProvider.future);
  final data =
      db.collection<models.Point>().watchObject(id, fireImmediately: true);
  await for (final results in data) {
    yield results;
  }
});

final pointBookmarkProvider = StreamProvider.autoDispose
    .family<models.UserBookmark?, String>((ref, id) async* {
  final db = await ref.watch(dbProvider.future);
  final query = db
      .collection<models.UserBookmark>()
      .filter()
      .typeEqualTo(models.UserBookmarkType.point)
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
      .collection<models.Point>()
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
      .collection<models.Event>()
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
    StreamProvider.autoDispose.family<models.Event?, int>((ref, id) async* {
  final db = await ref.watch(dbProvider.future);
  final data =
      db.collection<models.Event>().watchObject(id, fireImmediately: true);
  await for (final results in data) {
    yield results;
  }
});

final eventPointsProvider = StreamProvider.autoDispose
    .family<List<models.Point>, models.Event>((ref, event) async* {
  if (event.points.isEmpty) {
    yield [];
  } else {
    final locale =
        await ref.watch(appAuthProvider.selectAsync((data) => data.locale));
    final db = await ref.watch(dbProvider.future);

    final query = db
        .collection<models.Point>()
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

final routesProvider = StreamProvider.autoDispose((ref) async* {
  final locale =
      await ref.watch(appAuthProvider.selectAsync((data) => data.locale));
  final db = await ref.watch(dbProvider.future);
  final query = db
      .collection<models.Route>()
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

final routeProvider =
    StreamProvider.autoDispose.family<models.Route?, int>((ref, id) async* {
  final db = await ref.watch(dbProvider.future);
  final data =
      db.collection<models.Route>().watchObject(id, fireImmediately: true);
  await for (final results in data) {
    yield results;
  }
});

final routeWaypointsProvider = StreamProvider.autoDispose((ref) async* {
  final locale =
      await ref.watch(appAuthProvider.selectAsync((data) => data.locale));
  final db = await ref.watch(dbProvider.future);
  final query = db
      .collection<models.RouteWaypoint>()
      .filter()
      .localeEqualTo(locale)
      .routeIsNotEmpty()
      .sortByRoute()
      .build();

  await for (final results in query.watch(fireImmediately: true)) {
    if (results.isNotEmpty) {
      yield results;
    }
  }
});

final routeWaypointsByRouteProvider = StreamProvider.autoDispose
    .family<List<models.RouteWaypoint>, String>((ref, routeId) async* {
  final locale =
      await ref.watch(appAuthProvider.selectAsync((data) => data.locale));
  final db = await ref.watch(dbProvider.future);
  final query = db
      .collection<models.RouteWaypoint>()
      .filter()
      .localeEqualTo(locale)
      .routeEqualTo(routeId)
      .sortByOrder()
      .build();

  await for (final results in query.watch(fireImmediately: true)) {
    if (results.isNotEmpty) {
      yield results;
    }
  }
});

final routeLegsProvider = StreamProvider.autoDispose((ref) async* {
  final db = await ref.watch(dbProvider.future);
  final query = db
      .collection<models.RouteLeg>()
      .filter()
      .routeIsNotEmpty()
      .sortByRoute()
      .build();

  await for (final results in query.watch(fireImmediately: true)) {
    if (results.isNotEmpty) {
      yield results;
    }
  }
});

final routeLegsByRouteProvider = StreamProvider.autoDispose
    .family<List<models.RouteLeg>, String>((ref, routeId) async* {
  final db = await ref.watch(dbProvider.future);
  final query =
      db.collection<models.RouteLeg>().filter().routeEqualTo(routeId).build();

  await for (final results in query.watch(fireImmediately: true)) {
    if (results.isNotEmpty) {
      yield results;
    }
  }
});

final mapObjectsProvider =
    StreamProvider.autoDispose<List<models.MapObject>>((ref) async* {
  final filters = ref.watch(pointsFiltersProvider);
  final points = await ref.watch(pointsProvider.future);
  final routes = await ref.watch(routesProvider.future);

  if (filters.routes) {
    yield routes;
  } else {
    yield [...points, ...routes];
  }
});
