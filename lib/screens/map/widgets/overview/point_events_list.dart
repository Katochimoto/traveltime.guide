import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:traveltime/constants/theme.dart';
import 'package:traveltime/constants/routes.dart';
import 'package:traveltime/screens/map/widgets/popover/list_item_event.dart';
import 'package:traveltime/store/models.dart' as models;

class PointEventsList extends ConsumerWidget {
  const PointEventsList({
    super.key,
    required this.events,
  });

  final List<models.Event> events;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.eventsTitle,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: UIGap.g1),
        Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: UIGap.g2, vertical: UIGap.g1),
            child: Column(
              children: [
                for (final event in events)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: UIGap.g1),
                    child: ListItemEvent(
                      event: event,
                      onTap: (event) {
                        context.pushNamed(
                          Routes.event,
                          pathParameters: {'id': event.isarId.toString()},
                        );
                      },
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
