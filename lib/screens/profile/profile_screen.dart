import 'package:flutter/material.dart';
import 'package:traveltime/constants/routes.dart';
import 'package:traveltime/screens/profile/profile_details.dart';
import 'package:traveltime/widgets/navbar/navbar.dart';
import 'package:traveltime/widgets/drawer/drawer.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      extendBodyBehindAppBar: true,
      appBar: Navbar(isTransparent: true),
      drawer: AppDrawer(currentPage: Routes.profile),
      body: ProfileDetails(),
    );
  }
}
