import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:traveltime/screens/event/event_details.dart';
import 'package:traveltime/store/db.dart';
import 'package:traveltime/widgets/not_found.dart';

class EventView extends ConsumerWidget {
  const EventView({super.key, required this.id, this.date});

  final int id;
  final DateTime? date;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(eventProvider(id)).when(
          data: (data) => data == null
              ? const NotFound()
              : EventDetails(event: data, date: date),
          error: (error, stackTrace) => const NotFound(),
          loading: () => const Center(child: CircularProgressIndicator()),
        );
  }
}
