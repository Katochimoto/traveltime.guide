import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:traveltime/store/models/article.dart';

// final dbProvider = FutureProvider.autoDispose((ref) async {
//   final dir = await getApplicationSupportDirectory();
//   final db =
//       await Isar.open([ArticleSchema], directory: dir.path, inspector: true);
//   ref.onDispose(() => db.close());
//   return db;
// });

// final articlesProvider = StreamProvider.autoDispose((ref) async* {
//   final db = await ref.watch(dbProvider.future);
//   final query = db.articles.where().sortByPublishedAtDesc().build();

//   await for (final results in query.watch(fireImmediately: true)) {
//     if (results.isNotEmpty) {
//       yield results;
//     }
//   }
// });
