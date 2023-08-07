import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:traveltime/constants/theme.dart';
import 'package:traveltime/constants/routes.dart';
import 'package:traveltime/store/db_sync.dart';
import 'package:traveltime/providers/app_auth.dart';
import 'package:traveltime/widgets/navbar/navbar.dart';
import 'package:traveltime/widgets/page_layout.dart';
import 'package:traveltime/widgets/drawer/drawer.dart';

class ResetLocalData extends ConsumerWidget {
  const ResetLocalData({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
      onPressed: () {
        ref.read(dbSyncProvider.notifier).reset();
      },
      child: Text(AppLocalizations.of(context)!.settingsResetLocalData),
    );
  }
}

class SelectLocale extends ConsumerWidget {
  const SelectLocale({super.key});

  List<DropdownMenuItem<AppLocale>> get locales {
    List<DropdownMenuItem<AppLocale>> menuItems = [
      const DropdownMenuItem(value: AppLocale.en, child: Text('English')),
      const DropdownMenuItem(value: AppLocale.th, child: Text('Thai')),
    ];
    return menuItems;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authorized = ref.watch(appAuthProvider).value;
    return DropdownButton2(
      underline: const SizedBox.shrink(),
      alignment: AlignmentDirectional.bottomEnd,
      items: locales,
      value: authorized?.locale,
      onChanged: (value) {
        ref.watch(appAuthProvider.notifier).updateLocale(value);
      },
    );
  }
}

class SelectTheme extends ConsumerWidget {
  const SelectTheme({super.key});

  List<DropdownMenuItem<ThemeMode>> get themes {
    List<DropdownMenuItem<ThemeMode>> menuItems = [
      const DropdownMenuItem(value: ThemeMode.system, child: Text('System')),
      const DropdownMenuItem(value: ThemeMode.dark, child: Text('Dark')),
      const DropdownMenuItem(value: ThemeMode.light, child: Text('Light')),
    ];
    return menuItems;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authorized = ref.watch(appAuthProvider).value;
    return DropdownButton2(
      underline: const SizedBox.shrink(),
      alignment: AlignmentDirectional.bottomEnd,
      items: themes,
      value: authorized?.theme,
      onChanged: (value) {
        ref.watch(appAuthProvider.notifier).updateTheme(value);
      },
    );
  }
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  Widget _content(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: UIGap.g4),
        Text(
          "Recommended Settings",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        Text(
          "These are the most important settings",
          style: Theme.of(context).textTheme.titleSmall,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Language", style: Theme.of(context).textTheme.labelLarge),
            const SelectLocale(),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Theme", style: Theme.of(context).textTheme.labelLarge),
            const SelectTheme(),
          ],
        ),
        // TableCellSettings(
        //     title: "Notifications",
        //     onTap: () {
        //       Navigator.pushNamed(context, '/components');
        //     }),

        const SizedBox(height: UIGap.g5),
        Text(
          "Local Data",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        Text(
          "Third most important settings",
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const SizedBox(height: UIGap.g2),
        const ResetLocalData(),
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
