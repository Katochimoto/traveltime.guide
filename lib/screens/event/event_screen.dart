import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:traveltime/constants/routes.dart';
import 'package:traveltime/screens/event/event_view.dart';
import 'package:traveltime/widgets/navbar/navbar.dart';
import 'package:traveltime/widgets/drawer/drawer.dart';

class EventScreen extends ConsumerWidget {
  const EventScreen({
    super.key,
    required this.id,
    this.date,
    this.onBack,
  });

  final int id;
  final DateTime? date;
  final void Function(BuildContext context, WidgetRef ref)? onBack;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: Navbar(
        isTransparent: true,
        onBack: onBack != null
            ? () => onBack!(context, ref)
            : () => context.goNamed(Routes.events),
      ),
      drawer: const AppDrawer(currentPage: Routes.events),
      body: EventView(id: id, date: date),
    );
  }
}
