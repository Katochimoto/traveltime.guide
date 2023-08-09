import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExtraNavParams {
  const ExtraNavParams({this.onBack});
  final void Function(BuildContext context, WidgetRef ref)? onBack;
}
