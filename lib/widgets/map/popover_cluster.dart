import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:traveltime/constants/_theme.dart';
import 'package:traveltime/widgets/map/marker_list_item.dart';
import 'package:traveltime/providers/marker_popover.dart';

class PopoverCluster extends ConsumerWidget {
  final double width;
  final double height;
  final PopoverData popover;

  const PopoverCluster({
    super.key,
    required this.width,
    required this.height,
    required this.popover,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: const BorderRadius.all(Radius.circular(UIGap.g3)),
        ),
        child: MediaQuery.removePadding(
          context: context,
          removeTop: true,
          removeBottom: true,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(
                horizontal: UIGap.g2, vertical: UIGap.g2),
            physics: const BouncingScrollPhysics(),
            separatorBuilder: (context, index) =>
                const SizedBox(height: UIGap.g2),
            itemBuilder: (_, idx) {
              return MarkerListItemController(id: popover.pointIds![idx]!);
            },
            itemCount: popover.pointIds!.length,
          ),
        ),
      ),
    );
  }
}
