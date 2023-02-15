import 'package:flutter/material.dart';
import 'package:traveltime/constants/Theme.dart';

class Attribution extends StatelessWidget {
  const Attribution({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).canvasColor.withOpacity(0.75),
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(UIGap.g2),
                topRight: Radius.circular(UIGap.g2))),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 102, top: 1),
          child: Row(
            // mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'flutter_map | © ',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              Text(
                'OpenStreetMap contributors',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
