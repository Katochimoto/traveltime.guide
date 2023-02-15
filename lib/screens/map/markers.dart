import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:traveltime/widgets/map/marker_in_list.dart';

class Markers extends ConsumerWidget {
  const Markers({super.key, this.sc});

  final ScrollController? sc;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.builder(
      controller: sc,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (_, idx) {
        return const MarkerInList();
      },
      itemCount: 100,
    );
  }
}
