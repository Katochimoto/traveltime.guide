import 'package:flutter/material.dart';
import 'package:traveltime/screens/profile/detail_bookmarks.dart';
import 'package:traveltime/widgets/overview/overview_content.dart';

class ProfileDetails extends StatelessWidget {
  const ProfileDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return const OverviewContent(
      title: 'Demo',
      subtitle: 'Demo user',
      content: 'test',
      actions: [DetailBookmarks()],
    );
  }
}
