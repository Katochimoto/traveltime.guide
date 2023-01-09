import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:traveltime/constants/Theme.dart';
import 'package:traveltime/constants/routes.dart';

@immutable
class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      alignment: Alignment.center,
      children: [
        Container(
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColorDark,
                image: const DecorationImage(
                  image: AssetImage("assets/imgs/drawer_bg.jpg"),
                  fit: BoxFit.cover,
                  opacity: 0.1,
                ))),
        SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Image(
                  image: AssetImage("assets/imgs/logo3.png"),
                  width: 80,
                  height: 80),
              const SizedBox(height: UIGap.g4),
              Text(
                'TravelTime',
                style: Theme.of(context).primaryTextTheme.displayMedium,
              ),
              Text(
                'Thailand travel guide',
                style: Theme.of(context).primaryTextTheme.caption,
              ),
              const SizedBox(height: UIGap.g4),
              TextButton(
                style: TextButton.styleFrom(
                  // ElevatedButton
                  // elevation: 0,
                  shape: const StadiumBorder(),
                  // backgroundColor: Theme.of(context).primaryColor,
                ),
                onPressed: () {
                  context.goNamed(Routes.discover);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: UIGap.g2, vertical: UIGap.g0),
                  child: Text(
                    "GET STARTED",
                    style: Theme.of(context).primaryTextTheme.button,
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    ));
  }
}
