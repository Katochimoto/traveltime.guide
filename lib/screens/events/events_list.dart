import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:traveltime/constants/routes.dart';
import 'package:traveltime/widgets/card/card_horizontal.dart';
import 'package:traveltime/widgets/not_found.dart';
import 'package:traveltime/store/models/event.dart';

class EventsList extends StatelessWidget {
  final List<Event> events;

  const EventsList({super.key, required this.events});

  @override
  Widget build(BuildContext context) {
    if (events.isEmpty) {
      return const NotFound();
    }

    return ListView.builder(
      itemCount: events.length,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (_, idx) {
        final event = events[idx];
        return CardHorizontal(
            title: event.title,
            details: event.intro,
            img: event.logoImg,
            tap: () {
              context.pushNamed(Routes.event,
                  params: {'id': event.isarId.toString()});
            });
      },
    );
  }
}
