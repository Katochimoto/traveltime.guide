import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:traveltime/store/models/article.dart';
import 'package:traveltime/utils/app_auth.dart';
import 'package:traveltime/utils/app_support_directory.dart';

class Db extends AsyncNotifier<Isar> {
  @override
  Future<Isar> build() async {
    final user = await ref.watch(appAuthProvider.future);
    final dir = ref.watch(appSupportDirectoryProvider);
    final db = await Isar.open([ArticleSchema],
        name: 'traveltime:${user.locale.name}',
        directory: dir.path,
        inspector: true);
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
