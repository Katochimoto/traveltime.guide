import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class AppDetails extends StatefulWidget {
  const AppDetails({super.key});

  @override
  AppDetailsState createState() => AppDetailsState();
}

class AppDetailsState extends State<AppDetails> {
  PackageInfo? packageInfo;

  @override
  void initState() {
    super.initState();
    _fetchPackageInfo();
  }

  Future<void> _fetchPackageInfo() async {
    try {
      final data = await PackageInfo.fromPlatform();
      setState(() {
        packageInfo = data;
      });
    } catch (error, stackTrace) {
      await Sentry.captureException(error, stackTrace: stackTrace);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (packageInfo == null) {
      return const SizedBox.shrink();
    }

    return Text(
      'v${packageInfo!.version}+${packageInfo!.buildNumber}',
      style: Theme.of(context)
          .textTheme
          .merge(Typography.whiteCupertino)
          .bodySmall,
    );
  }
}
