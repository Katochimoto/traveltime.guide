import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:traveltime/screens/article/article_details.dart';
import 'package:traveltime/store/db.dart';
import 'package:traveltime/widgets/not_found.dart';

class ArticleView extends ConsumerWidget {
  const ArticleView({super.key, required this.id});

  final int id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(articleProvider(id)).when(
          data: (data) {
            return data == null
                ? const NotFound()
                : ArticleDetails(article: data);
          },
          error: (error, stackTrace) => const NotFound(),
          loading: () => const Center(child: CircularProgressIndicator()),
        );
  }
}
