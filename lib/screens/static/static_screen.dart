import 'package:flutter/material.dart';
import 'package:traveltime/screens/static/static_view.dart';
import 'package:traveltime/widgets/navbar/navbar.dart';
import 'package:traveltime/widgets/drawer/drawer.dart';
import 'package:traveltime/store/models.dart' as models;

class StaticScreen extends StatelessWidget {
  const StaticScreen({
    super.key,
    required this.routeName,
    required this.type,
  });

  final String routeName;
  final models.PageType type;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Navbar(),
      drawer: AppDrawer(currentPage: routeName),
      body: StaticView(type: type),
    );
  }
}
