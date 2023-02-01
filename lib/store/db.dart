import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:traveltime/store/models/article.dart';
import 'package:traveltime/utils/app_auth.dart';

class Db extends AsyncNotifier<Isar> {
  @override
  Future<Isar> build() async {
    final locale =
        await ref.watch(appAuthProvider.selectAsync((value) => value.locale));
    final name = 'traveltime:${locale.name}';

    var db = Isar.getInstance(name);
    if (db == null || !db.isOpen) {
      final dir = await getApplicationSupportDirectory();
      db = await Isar.open([ArticleSchema],
          name: name, directory: dir.path, inspector: true);
    }

    return db;
  }
}

final dbProvider = AsyncNotifierProvider<Db, Isar>(() {
  return Db();
});

final articlesProvider = StreamProvider.autoDispose((ref) async* {
  final db = await ref.watch(dbProvider.future);
  final query =
      db.collection<Article>().where().sortByPublishedAtDesc().build();

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
