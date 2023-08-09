import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:traveltime/constants/theme.dart';
import 'package:traveltime/providers/overview/overview.dart';
import 'package:traveltime/store/db.dart';
import 'package:traveltime/store/models.dart' as models;
import 'package:traveltime/providers/marker_popover.dart';

class RouteListItemController extends ConsumerWidget {
  const RouteListItemController({
    super.key,
    required this.id,
  });

  final int id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final route = ref.watch(routeProvider(id));
    return route.when(
      data: (data) {
        return data == null
            ? const SizedBox.shrink()
            : RouteListItem(
                route: data,
                onTap: (route) {
                  ref
                      .read(overviewProvider.notifier)
                      .show(OverviewData(object: route));
                  ref.read(popoverProvider.notifier).hide();
                });
      },
      error: (error, stackTrace) {
        return const SizedBox.shrink();
      },
      loading: () {
        return const SizedBox.shrink();
      },
    );
  }
}

class RouteListItem extends StatelessWidget {
  const RouteListItem({super.key, required this.route, this.onTap});

  final models.Route route;
  final void Function(models.Route route)? onTap;

  @override
  Widget build(BuildContext context) {
    const height = 65.0;
    return ElevatedButton(
      onPressed: () {
        onTap?.call(route);
      },
      style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: const EdgeInsets.all(0),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(UIGap.g3)))),
      child: SizedBox(
        height: height,
        child: Row(children: [
          if (route.logoImg != null)
            Container(
              width: height,
              height: height,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondaryContainer,
                borderRadius: const BorderRadius.all(Radius.circular(UIGap.g3)),
              ),
              child: Image.network(
                route.logoImg!,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const Center(
                    child: SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  );
                },
                frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                  return child;
                },
                errorBuilder: (context, error, stackTrace) {
                  return const Center(
                    child: Icon(Icons.image_not_supported_outlined, size: 20),
                  );
                },
              ),
            ),
          Flexible(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: UIGap.g1, horizontal: UIGap.g2),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(route.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyMedium),
                    Text(route.intro ?? route.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodySmall),
                  ]),
            ),
          ),
        ]),
      ),
    );
  }
}
