import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:traveltime/constants/Theme.dart';
import 'package:traveltime/constants/routes.dart';
import 'package:traveltime/store/db_sync.dart';

class DbSyncProgress extends StatelessWidget {
  const DbSyncProgress({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 50.0,
      width: 50.0,
      child: CircularProgressIndicator(),
    );
  }
}

class DbSyncSuccess extends StatelessWidget {
  const DbSyncSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 50.0,
        child: TextButton(
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
              style: Theme.of(context).primaryTextTheme.labelLarge,
            ),
          ),
        ));
  }
}

class DbSyncStatus extends ConsumerWidget {
  const DbSyncStatus({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(dbSyncProvider);
    return state.when(
        skipLoadingOnReload: true,
        skipLoadingOnRefresh: true,
        data: (data) {
          if (data.status == DBSyncStatus.runing) {
            return const DbSyncProgress();
          }
          return const DbSyncSuccess();
        },
        error: (error, stackTrace) {
          Sentry.captureException(error, stackTrace: stackTrace);
          return const DbSyncSuccess();
        },
        loading: () {
          return const DbSyncProgress();
        });
  }
}

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

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
                style: Theme.of(context).primaryTextTheme.bodySmall,
              ),
              const SizedBox(height: UIGap.g4),
              const DbSyncStatus(),
            ],
          ),
        )
      ],
    ));
  }
}
