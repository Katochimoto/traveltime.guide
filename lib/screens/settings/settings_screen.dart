import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:traveltime/constants/Theme.dart';
import 'package:traveltime/constants/routes.dart';

//widgets
import 'package:traveltime/widgets/navbar/navbar.dart';
import 'package:traveltime/widgets/page_layout.dart';
import 'package:traveltime/widgets/table-cell.dart';

import 'package:traveltime/widgets/drawer/drawer.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<SettingsScreen> {
  late bool switchValueOne;
  late bool switchValueTwo;

  @override
  void initState() {
    setState(() {
      switchValueOne = true;
      switchValueTwo = false;
    });
    super.initState();
  }

  Widget _content(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: UIGap.g4),
        Text(
          "Recommended Settings",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        Text(
          "These are the most important settings",
          style: Theme.of(context).textTheme.subtitle2,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Use FaceID to signin",
                style: Theme.of(context).textTheme.labelLarge),
            Switch.adaptive(
              value: switchValueOne,
              onChanged: (bool newValue) =>
                  setState(() => switchValueOne = newValue),
              activeColor: Theme.of(context).primaryColor,
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Auto-Lock security",
                style: Theme.of(context).textTheme.labelLarge),
            Switch.adaptive(
              value: switchValueTwo,
              onChanged: (bool newValue) =>
                  setState(() => switchValueTwo = newValue),
              activeColor: Theme.of(context).primaryColor,
            )
          ],
        ),
        TableCellSettings(
            title: "Notifications",
            onTap: () {
              Navigator.pushNamed(context, '/components');
            }),
        const SizedBox(height: UIGap.g5),
        Text(
          "Privacy Settings",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        Text(
          "Third most important settings",
          style: Theme.of(context).textTheme.subtitle2,
        ),
        TableCellSettings(
            title: "User Agreement",
            onTap: () {
              Navigator.pushNamed(context, '/components');
            }),
        TableCellSettings(
            title: "Privacy",
            onTap: () {
              Navigator.pushNamed(context, '/components');
            }),
        TableCellSettings(
            title: "About",
            onTap: () {
              Navigator.pushNamed(context, '/components');
            }),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Navbar(
          title: AppLocalizations.of(context)!.settingsTitle,
        ),
        drawer: const AppDrawer(currentPage: Routes.settings),
        body: PageLayout(child: _content(context)));
  }
}
