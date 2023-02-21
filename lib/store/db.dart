import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:traveltime/providers/app_auth.dart';
import 'package:traveltime/providers/points_filters.dart';
import 'package:traveltime/store/models/article.dart';
import 'package:traveltime/store/models/point.dart';
import 'package:traveltime/store/models/user_favorite.dart';

class Db extends AsyncNotifier<Isar> {
  @override
  Future<Isar> build() async {
    const name = r'traveltime';

    var db = Isar.getInstance(name);
    if (db == null || !db.isOpen) {
      final dir = await getApplicationSupportDirectory();
      db = await Isar.open([ArticleSchema, PointSchema, UserFavoriteSchema],
          name: name, directory: dir.path, inspector: true);
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
  final filters = ref.watch(pointsFiltersProvider);
  final locale =
      await ref.watch(appAuthProvider.selectAsync((data) => data.locale));
  final db = await ref.watch(dbProvider.future);

  final query = db
      .collection<Point>()
      .filter()
      .localeEqualTo(locale)
      .anyOf(filters.categories, (q, value) => q.categoryEqualTo(value))
      .sortByPublishedAtDesc()
      .build();

  await for (final results in query.watch(fireImmediately: true)) {
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
