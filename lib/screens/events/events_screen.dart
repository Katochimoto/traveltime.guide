import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:traveltime/constants/routes.dart';
import 'package:traveltime/widgets/drawer/drawer.dart';
import 'package:traveltime/widgets/navbar/navbar.dart';
import 'package:traveltime/widgets/page_layout.dart';

class EventsScreen extends StatelessWidget {
  const EventsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Navbar(
          title: AppLocalizations.of(context)!.eventsTitle,
        ),
        drawer: const AppDrawer(currentPage: Routes.events),
        body: const PageLayout(
          scroll: false,
          child: Text('asd'),
        ));
  }
}
