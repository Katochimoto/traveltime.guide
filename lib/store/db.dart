import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:traveltime/providers.dart';
import 'package:traveltime/store/models/article.dart';

final dbProvider = FutureProvider((ref) async {
  final locale = ref.watch(localeProvider);
  return Isar.open([ArticleSchema],
      name: 'traveltime:${locale.toString()}', inspector: true);
});
