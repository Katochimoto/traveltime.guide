import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Marks extends ConsumerWidget {
  const Marks({super.key, this.sc, this.padding});

  final ScrollController? sc;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView(
      controller: sc,
      padding: padding,
      physics: const BouncingScrollPhysics(),
      children: const <Widget>[
        Text('asd'),
      ],
    );
  }
}
