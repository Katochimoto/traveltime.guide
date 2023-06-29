import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:traveltime/constants/Theme.dart';
import 'package:traveltime/providers/overview/overview.dart';

class OverviewNavbar extends ConsumerWidget {
  const OverviewNavbar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
        padding: const EdgeInsets.symmetric(
            vertical: UIGap.g2, horizontal: UIGap.g2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              style: IconButton.styleFrom(
                backgroundColor: Theme.of(context).canvasColor,
              ),
              iconSize: 24,
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                ref.invalidate(overviewProvider);
              },
            )
          ],
        ));
  }
}
