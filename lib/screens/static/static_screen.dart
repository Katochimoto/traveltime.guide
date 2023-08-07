import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:traveltime/screens/static/static_view.dart';
import 'package:traveltime/widgets/navbar/navbar.dart';
import 'package:traveltime/widgets/drawer/drawer.dart';
import 'package:traveltime/store/models.dart' as models;

class StaticScreen extends StatelessWidget {
  const StaticScreen({
    super.key,
    required this.routeName,
    required this.type,
  });

  final String routeName;
  final models.PageType type;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final titles = <models.PageType, String>{
      models.PageType.about: loc.aboutTitle,
      models.PageType.terms: loc.termsTitle,
      models.PageType.disclaimer: loc.disclaimerTitle,
      models.PageType.policy: loc.policyTitle,
    };
    return Scaffold(
      appBar: Navbar(title: titles[type]),
      drawer: AppDrawer(currentPage: routeName),
      body: StaticView(type: type),
    );
  }
}
