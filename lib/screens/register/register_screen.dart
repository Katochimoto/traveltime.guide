import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:traveltime/constants/Theme.dart';
import 'package:traveltime/constants/routes.dart';

//widgets
import 'package:traveltime/widgets/navbar/navbar.dart';
import 'package:traveltime/widgets/input.dart';

import 'package:traveltime/widgets/drawer/drawer.dart';

@immutable
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  RegisterScreenState createState() => RegisterScreenState();
}

class RegisterScreenState extends State<RegisterScreen> {
  bool _checkboxValue = false;

  final double height = window.physicalSize.height;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const Navbar(
          title: "",
        ),
        extendBodyBehindAppBar: true,
        drawer: const AppDrawer(currentPage: Routes.account),
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/imgs/register-bg.png"),
                      fit: BoxFit.cover)),
            ),
            SafeArea(
              child: ListView(children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 16, left: 16.0, right: 16.0, bottom: 32),
                  child: Card(
                      elevation: 5,
                      clipBehavior: Clip.antiAlias,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: Container(
                          height: MediaQuery.of(context).size.height * 0.78,
                          color: NowUIColors.bgColorScreen,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  const Padding(
                                    padding:
                                        EdgeInsets.only(top: 24.0, bottom: 8),
                                    child: Center(
                                        child: Text("Register",
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w600))),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      RawMaterialButton(
                                        onPressed: () {},
                                        elevation: 4.0,
                                        fillColor: NowUIColors.socialFacebook,
                                        padding: const EdgeInsets.all(15.0),
                                        shape: const CircleBorder(),
                                        child: const Icon(
                                            FontAwesomeIcons.facebook,
                                            size: 16.0,
                                            color: Colors.white),
                                      ),
                                      RawMaterialButton(
                                        onPressed: () {},
                                        elevation: 4.0,
                                        fillColor: NowUIColors.socialTwitter,
                                        padding: const EdgeInsets.all(15.0),
                                        shape: const CircleBorder(),
                                        child: const Icon(
                                            FontAwesomeIcons.twitter,
                                            size: 16.0,
                                            color: Colors.white),
                                      ),
                                      RawMaterialButton(
                                        onPressed: () {},
                                        elevation: 4.0,
                                        fillColor: NowUIColors.socialDribbble,
                                        padding: const EdgeInsets.all(15.0),
                                        shape: const CircleBorder(),
                                        child: const Icon(
                                            FontAwesomeIcons.dribbble,
                                            size: 16.0,
                                            color: Colors.white),
                                      )
                                    ],
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(
                                        top: 24.0, bottom: 24.0),
                                    child: Center(
                                      child: Text("or be classical",
                                          style: TextStyle(
                                              color: NowUIColors.time,
                                              fontWeight: FontWeight.w200,
                                              fontSize: 16)),
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Input(
                                          placeholder: "First Name...",
                                          prefixIcon:
                                              Icon(Icons.school, size: 20),
                                        ),
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Input(
                                            placeholder: "Last Name...",
                                            prefixIcon:
                                                Icon(Icons.email, size: 20)),
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.only(
                                            top: 8.0,
                                            left: 8.0,
                                            right: 8.0,
                                            bottom: 0),
                                        child: Input(
                                            placeholder: "Your Email...",
                                            prefixIcon:
                                                Icon(Icons.lock, size: 20)),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8.0, top: 0, bottom: 16),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Checkbox(
                                                activeColor:
                                                    NowUIColors.primary,
                                                onChanged: (bool? newValue) =>
                                                    setState(() =>
                                                        _checkboxValue =
                                                            newValue ?? false),
                                                value: _checkboxValue),
                                            const Text(
                                                "I agree with the terms and conditions",
                                                style: TextStyle(
                                                    color: NowUIColors.black,
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w200)),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Center(
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          shape: const StadiumBorder()),
                                      onPressed: () {
                                        // Respond to button press
                                        context.goNamed(Routes.discover);
                                      },
                                      child: const Padding(
                                          padding: EdgeInsets.only(
                                              left: 32.0,
                                              right: 32.0,
                                              top: 12,
                                              bottom: 12),
                                          child: Text("Get Started",
                                              style:
                                                  TextStyle(fontSize: 14.0))),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ))),
                ),
              ]),
            )
          ],
        ));
  }
}
