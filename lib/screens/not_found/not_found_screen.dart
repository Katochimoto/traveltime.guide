import 'package:flutter/material.dart';
import 'package:traveltime/widgets/drawer/drawer.dart';
import 'package:traveltime/widgets/navbar/navbar.dart';
import 'package:traveltime/widgets/not_found.dart';

class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({
    super.key,
    required this.routeName,
  });

  final String routeName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Navbar(),
      drawer: AppDrawer(currentPage: routeName),
      body: const NotFound(
        text: 'Page is in development',
      ),
    );
  }
}
