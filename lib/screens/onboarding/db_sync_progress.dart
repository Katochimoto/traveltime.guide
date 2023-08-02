import 'package:flutter/material.dart';

class DbSyncProgress extends StatelessWidget {
  const DbSyncProgress({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 50.0,
      width: 50.0,
      child: CircularProgressIndicator(),
    );
  }
}
