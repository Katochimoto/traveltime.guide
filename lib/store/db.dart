import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:traveltime/store/models/article.dart';
import 'package:traveltime/utils/app_auth.dart';
import 'package:traveltime/utils/app_support_directory.dart';

final dbProvider = Provider<Isar>((ref) {
  final dir = ref.watch(appSupportDirectoryProvider);
  final locale =
      ref.watch(appAuthProvider.select((auth) => auth.authorized.locale));
  return Isar.openSync([ArticleSchema],
      name: 'traveltime:${locale.name}', directory: dir.path, inspector: true);
});

final articlesProvider = StreamProvider.autoDispose((ref) async* {
  final db = ref.watch(dbProvider);
  final query =
      db.collection<Article>().where().sortByPublishedAtDesc().build();

  await for (final results in query.watch(fireImmediately: true)) {
    if (results.isNotEmpty) {
      yield results;
    }
  }
});
