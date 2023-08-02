import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:traveltime/constants/theme.dart';
import 'package:traveltime/screens/onboarding/db_sync_status.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final textTheme =
        Theme.of(context).textTheme.merge(Typography.whiteCupertino);
    return Scaffold(
        body: Stack(
      alignment: Alignment.center,
      children: [
        Container(
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColorDark,
                image: const DecorationImage(
                  image: AssetImage("assets/imgs/drawer_bg.jpg"),
                  fit: BoxFit.cover,
                  opacity: 0.1,
                ))),
        SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Image(
                  image: AssetImage("assets/imgs/logo.png"),
                  width: 80,
                  height: 80),
              const SizedBox(height: UIGap.g4),
              Text(loc.appTitle, style: textTheme.displayMedium),
              Text(loc.appSubtitle, style: textTheme.bodySmall),
              const SizedBox(height: UIGap.g4),
              const DbSyncStatus(),
            ],
          ),
        )
      ],
    ));
  }
}
