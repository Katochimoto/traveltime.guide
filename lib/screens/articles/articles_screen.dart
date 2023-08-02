import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:traveltime/constants/routes.dart';
import 'package:traveltime/screens/articles/articles_list.dart';
import 'package:traveltime/widgets/drawer/drawer.dart';
import 'package:traveltime/widgets/navbar/navbar.dart';
import 'package:traveltime/widgets/page_layout.dart';

class ArticlesScreen extends StatelessWidget {
  const ArticlesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Navbar(
          title: AppLocalizations.of(context)!.articlesTitle,
        ),
        drawer: const AppDrawer(currentPage: Routes.articles),
        body: const PageLayout(
          scroll: false,
          child: ArticlesList(),
        ));
  }
}
