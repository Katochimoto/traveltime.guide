import 'package:flutter/material.dart';
import 'package:traveltime/constants/routes.dart';
import 'package:traveltime/screens/article/article_view.dart';
import 'package:traveltime/widgets/navbar/navbar.dart';
import 'package:traveltime/widgets/drawer/drawer.dart';

class ArticleScreen extends StatelessWidget {
  final int id;

  const ArticleScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: const Navbar(
          isTransparent: true,
        ),
        drawer: const AppDrawer(currentPage: Routes.articles),
        body: ArticleView(id: id));
  }
}
