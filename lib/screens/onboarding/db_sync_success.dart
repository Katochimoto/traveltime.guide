import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:traveltime/constants/theme.dart';
import 'package:traveltime/constants/routes.dart';

class DbSyncSuccess extends StatelessWidget {
  const DbSyncSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final textTheme =
        Theme.of(context).textTheme.merge(Typography.whiteCupertino);
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
            child: Text(loc.getStarted, style: textTheme.labelLarge),
          ),
        ));
  }
}
