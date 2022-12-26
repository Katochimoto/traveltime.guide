import 'package:flutter/material.dart';

import 'package:teamtravel/constants/Theme.dart';

//widgets
import 'package:teamtravel/widgets/navbar.dart';
import 'package:teamtravel/widgets/table-cell.dart';

import 'package:teamtravel/widgets/drawer.dart';

class SettingsScreen extends StatefulWidget {
  static String routeName = "/settings";

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<SettingsScreen> {
  late bool switchValueOne;
  late bool switchValueTwo;

  @override
  void initState() {
    setState(() {
      switchValueOne = true;
      switchValueTwo = false;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const Navbar(
          title: "Settings",
        ),
        drawer: NowDrawer(currentPage: SettingsScreen.routeName),
        body: Container(
            child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 32.0, left: 16, right: 16),
            child: Column(
              children: [
                const Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: Text("Recommended Settings",
                        style: TextStyle(
                            color: NowUIColors.text,
                            fontWeight: FontWeight.w600,
                            fontSize: 18)),
                  ),
                ),
                const Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: Text("These are the most important settings",
                        style:
                            TextStyle(color: NowUIColors.time, fontSize: 14)),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Use FaceID to signin",
                        style: TextStyle(color: NowUIColors.text)),
                    Switch.adaptive(
                      value: switchValueOne,
                      onChanged: (bool newValue) =>
                          setState(() => switchValueOne = newValue),
                      activeColor: NowUIColors.primary,
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Auto-Lock security",
                        style: TextStyle(color: NowUIColors.text)),
                    Switch.adaptive(
                      value: switchValueTwo,
                      onChanged: (bool newValue) =>
                          setState(() => switchValueTwo = newValue),
                      activeColor: NowUIColors.primary,
                    )
                  ],
                ),
                TableCellSettings(
                    title: "Notifications",
                    onTap: () {
                      Navigator.pushNamed(context, '/components');
                    }),
                const SizedBox(height: 36.0),
                const Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 16.0),
                    child: Text("Payment Settings",
                        style: TextStyle(
                            color: NowUIColors.text,
                            fontWeight: FontWeight.w600,
                            fontSize: 18)),
                  ),
                ),
                const Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: Text("These are also important settings",
                        style: TextStyle(color: NowUIColors.time)),
                  ),
                ),
                const TableCellSettings(title: "Manage Payment Options"),
                const TableCellSettings(title: "Manage Gift Cards"),
                const SizedBox(
                  height: 36.0,
                ),
                const Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 16.0),
                    child: Text("Privacy Settings",
                        style: TextStyle(
                            color: NowUIColors.text,
                            fontWeight: FontWeight.w600,
                            fontSize: 18)),
                  ),
                ),
                const Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: Text("Third most important settings",
                        style: TextStyle(color: NowUIColors.time)),
                  ),
                ),
                TableCellSettings(
                    title: "User Agreement",
                    onTap: () {
                      Navigator.pushNamed(context, '/components');
                    }),
                TableCellSettings(
                    title: "Privacy",
                    onTap: () {
                      Navigator.pushNamed(context, '/components');
                    }),
                TableCellSettings(
                    title: "About",
                    onTap: () {
                      Navigator.pushNamed(context, '/components');
                    }),
              ],
            ),
          ),
        )));
  }
}
