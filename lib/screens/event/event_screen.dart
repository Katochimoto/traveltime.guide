import 'package:flutter/material.dart';
import 'package:traveltime/constants/routes.dart';
import 'package:traveltime/widgets/drawer/drawer.dart';
import 'package:traveltime/widgets/navbar/navbar.dart';
import 'package:traveltime/widgets/page_layout.dart';

class EventScreen extends StatelessWidget {
  final int id;

  const EventScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        extendBodyBehindAppBar: true,
        appBar: Navbar(
          isTransparent: true,
        ),
        drawer: AppDrawer(currentPage: Routes.events),
        body: PageLayout(
          child: Text('asd'),
        ));
  }
}
