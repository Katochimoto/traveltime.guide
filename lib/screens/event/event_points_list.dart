import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:traveltime/constants/theme.dart';
import 'package:traveltime/constants/routes.dart';
import 'package:traveltime/providers/overview/overview.dart';
import 'package:traveltime/store/models.dart' as models;
import 'package:traveltime/screens/map/widgets/popover/marker_list_item.dart';

class EventPointsList extends ConsumerWidget {
  const EventPointsList({super.key, required this.points});

  final List<models.Point> points;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.location,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: UIGap.g1),
        Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: UIGap.g2, vertical: UIGap.g1),
            child: Column(
              children: [
                for (final point in points)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: UIGap.g1),
                    child: MarkerListItem(
                      point: point,
                      onTap: (point) {
                        ref
                            .read(overviewProvider.notifier)
                            .show(OverviewData(object: point));
                        context.pushNamed(Routes.map);
                      },
                    ),
                  ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
