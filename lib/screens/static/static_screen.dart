import 'package:flutter/material.dart';
import 'package:traveltime/screens/static/static_view.dart';
import 'package:traveltime/widgets/navbar/navbar.dart';
import 'package:traveltime/widgets/drawer/drawer.dart';

class StaticScreen extends StatelessWidget {
  const StaticScreen({
    super.key,
    required this.routeName,
  });

  final String routeName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Navbar(),
      drawer: AppDrawer(currentPage: routeName),
      body: const StaticView(),
    );
  }
}
