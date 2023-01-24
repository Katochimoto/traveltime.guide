import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:traveltime/constants/Theme.dart';
import 'package:traveltime/constants/routes.dart';
import 'package:traveltime/store/db_sync.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  OnboardingScreenState createState() => OnboardingScreenState();
}

class OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  late DbSync? dbSync;

  @override
  void initState() {
    super.initState();
    initialization();
  }

  @override
  void dispose() {
    super.dispose();
    dbSync?.stop();
  }

  void initialization() async {
    dbSync = await ref.read(dbSyncProvider.future);
    dbSync?.start();
  }

  @override
  Widget build(BuildContext context) {
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
              Text(
                AppLocalizations.of(context)!.appTitle,
                style: Theme.of(context).primaryTextTheme.displayMedium,
              ),
              Text(
                AppLocalizations.of(context)!.appSubtitle,
                style: Theme.of(context).primaryTextTheme.caption,
              ),
              const SizedBox(height: UIGap.g4),
              const CircularProgressIndicator(),
              TextButton(
                style: TextButton.styleFrom(
                  shape: const StadiumBorder(),
                ),
                onPressed: () {
                  context.goNamed(Routes.discover);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: UIGap.g2, vertical: UIGap.g0),
                  child: Text(
                    AppLocalizations.of(context)!.getStarted,
                    style: Theme.of(context).primaryTextTheme.button,
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    ));
  }
}
