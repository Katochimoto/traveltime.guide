import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:traveltime/constants/routes.dart';
import 'package:traveltime/constants/theme.dart';
import 'package:traveltime/store/db.dart';
import 'package:traveltime/widgets/card/card_horizontal.dart';
import 'package:traveltime/widgets/not_found.dart';

class ArticlesList extends ConsumerWidget {
  const ArticlesList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(articlesProvider).when(
          data: (data) => data.isEmpty
              ? const NotFound()
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: UIGap.g2),
                  itemCount: data.length,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (_, idx) {
                    final article = data[idx];
                    return CardHorizontal(
                        title: article.title,
                        details: article.intro,
                        img: article.logoImg,
                        tap: () {
                          context.pushNamed(Routes.article, pathParameters: {
                            'id': article.isarId.toString()
                          });
                        });
                  },
                ),
          error: (error, stackTrace) => const NotFound(),
          loading: () => const Center(child: CircularProgressIndicator()),
        );
  }
}
