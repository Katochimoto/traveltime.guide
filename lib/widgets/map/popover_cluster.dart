import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:traveltime/constants/Theme.dart';
import 'package:traveltime/widgets/map/marker_in_list.dart';
import 'package:traveltime/widgets/map/popover_provider.dart';

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
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: UIGap.g1),
            physics: const BouncingScrollPhysics(),
            itemBuilder: (_, idx) {
              return const MarkerInList();
            },
            itemCount: 5,
          ),
        ),
      ),
    );
  }
}
