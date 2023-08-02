import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:traveltime/screens/onboarding/db_sync_progress.dart';
import 'package:traveltime/screens/onboarding/db_sync_success.dart';
import 'package:traveltime/store/db_sync.dart';

class DbSyncStatus extends ConsumerWidget {
  const DbSyncStatus({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(dbSyncProvider).when(
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
          loading: () => const DbSyncProgress(),
        );
  }
}
