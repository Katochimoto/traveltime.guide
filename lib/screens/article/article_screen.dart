import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:traveltime/constants/routes.dart';
import 'package:traveltime/screens/article/article_view.dart';
import 'package:traveltime/widgets/navbar/navbar.dart';
import 'package:traveltime/widgets/drawer/drawer.dart';

class ArticleScreen extends StatelessWidget {
  const ArticleScreen({super.key, required this.id});

  final int id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: Navbar(
        isTransparent: true,
        onBack: () => context.goNamed(Routes.articles),
      ),
      drawer: const AppDrawer(currentPage: Routes.articles),
      body: ArticleView(id: id),
    );
  }
}
