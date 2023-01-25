import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:traveltime/providers.dart';
import 'package:traveltime/store/models/article.dart';

final dbProvider = FutureProvider((ref) async {
  final locale = ref.watch(localeProvider);
  return Isar.open([ArticleSchema],
      name: 'traveltime:${locale.name}', inspector: true);
});

final articlesProvider = StreamProvider.autoDispose((ref) async* {
  final db = await ref.watch(dbProvider.future);
  final query = db.articles.where().sortByPublishedAtDesc().build();

  await for (final results in query.watch(fireImmediately: true)) {
    if (results.isNotEmpty) {
      yield results;
    }
  }
});
