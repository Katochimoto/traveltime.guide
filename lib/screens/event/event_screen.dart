import 'package:flutter/material.dart';
import 'package:traveltime/constants/routes.dart';
import 'package:traveltime/screens/event/event_view.dart';
import 'package:traveltime/widgets/navbar/navbar.dart';
import 'package:traveltime/widgets/drawer/drawer.dart';

class EventScreen extends StatelessWidget {
  const EventScreen({super.key, required this.id, this.date});

  final int id;
  final DateTime? date;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const Navbar(isTransparent: true),
      drawer: const AppDrawer(currentPage: Routes.events),
      body: EventView(id: id, date: date),
    );
  }
}
