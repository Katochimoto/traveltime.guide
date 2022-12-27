import 'package:flutter/material.dart';

import 'package:teamtravel/constants/Theme.dart';
import 'package:teamtravel/constants/routes.dart';

//widgets
import 'package:teamtravel/widgets/navbar/navbar.dart';
import 'package:teamtravel/widgets/drawer.dart';
import 'package:teamtravel/widgets/input.dart';
import 'package:teamtravel/widgets/table-cell.dart';

@immutable
class ComponentsScreen extends StatefulWidget {
  const ComponentsScreen({super.key});

  @override
  _ComponentsState createState() => _ComponentsState();
}

class _ComponentsState extends State<ComponentsScreen> {
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
          title: "Components",
        ),
        backgroundColor: NowUIColors.bgColorScreen,
        drawer: const NowDrawer(currentPage: Routes.components),
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.only(right: 16, left: 16, bottom: 36),
          child: SafeArea(
            bottom: true,
            child: Column(children: [
              const Padding(
                padding: EdgeInsets.only(left: 8.0, top: 32, bottom: 32),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Buttons",
                      style: TextStyle(
                          color: NowUIColors.text,
                          fontWeight: FontWeight.w600,
                          fontSize: 16)),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: NowUIColors.defaultColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                  ),
                  onPressed: () {
                    // Respond to button press
                    Navigator.pushReplacementNamed(context, '/home');
                  },
                  child: const Padding(
                      padding: EdgeInsets.only(
                          left: 16.0, right: 16.0, top: 12, bottom: 12),
                      child: Text("DEFAULT", style: TextStyle(fontSize: 14.0))),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: NowUIColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                    ),
                    onPressed: () {
                      // Respond to button press
                      Navigator.pushReplacementNamed(context, '/home');
                    },
                    child: const Padding(
                        padding: EdgeInsets.only(
                            left: 16.0, right: 16.0, top: 12, bottom: 12),
                        child:
                            Text("PRIMARY", style: TextStyle(fontSize: 14.0))),
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: NowUIColors.info,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                    ),
                    onPressed: () {
                      // Respond to button press
                      Navigator.pushReplacementNamed(context, '/home');
                    },
                    child: const Padding(
                        padding: EdgeInsets.only(
                            left: 16.0, right: 16.0, top: 12, bottom: 12),
                        child: Text("INFO", style: TextStyle(fontSize: 14.0))),
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: NowUIColors.success,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                    ),
                    onPressed: () {
                      // Respond to button press
                      Navigator.pushReplacementNamed(context, '/home');
                    },
                    child: const Padding(
                        padding: EdgeInsets.only(
                            left: 16.0, right: 16.0, top: 12, bottom: 12),
                        child:
                            Text("SUCCESS", style: TextStyle(fontSize: 14.0))),
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: NowUIColors.warning,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                    ),
                    onPressed: () {
                      // Respond to button press
                      Navigator.pushReplacementNamed(context, '/home');
                    },
                    child: const Padding(
                        padding: EdgeInsets.only(
                            left: 16.0, right: 16.0, top: 12, bottom: 12),
                        child:
                            Text("WARNING", style: TextStyle(fontSize: 14.0))),
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: NowUIColors.error,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                    ),
                    onPressed: () {
                      // Respond to button press
                      Navigator.pushReplacementNamed(context, '/home');
                    },
                    child: const Padding(
                        padding: EdgeInsets.only(
                            left: 16.0, right: 16.0, top: 12, bottom: 12),
                        child: Text("ERROR", style: TextStyle(fontSize: 14.0))),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 8.0, top: 32),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Typography",
                      style: TextStyle(
                          color: NowUIColors.text,
                          fontWeight: FontWeight.w600,
                          fontSize: 16)),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 16.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Heading 1",
                      style: TextStyle(fontSize: 44, color: NowUIColors.text)),
                ),
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text("Heading 2",
                    style: TextStyle(fontSize: 38, color: NowUIColors.text)),
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text("Heading 3",
                    style: TextStyle(fontSize: 30, color: NowUIColors.text)),
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text("Heading 4",
                    style: TextStyle(fontSize: 24, color: NowUIColors.text)),
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text("Heading 5",
                    style: TextStyle(fontSize: 21, color: NowUIColors.text)),
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text("Paragraph",
                    style: TextStyle(fontSize: 16, color: NowUIColors.text)),
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text("This is a muted paragraph.",
                    style: TextStyle(fontSize: 16, color: NowUIColors.muted)),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 8.0, top: 32),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Inputs",
                      style: TextStyle(
                          color: NowUIColors.text,
                          fontWeight: FontWeight.w600,
                          fontSize: 16)),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 32.0),
                child: Input(
                  placeholder: "Regular",
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 16.0),
                child: Input(
                  placeholder: "Custom border",
                  borderColor: NowUIColors.info,
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 16.0),
                child: Input(
                  placeholder: "Icon left",
                  prefixIcon: Icon(Icons.ac_unit),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 16.0),
                child: Input(
                  placeholder: "Icon right",
                  suffixIcon: Icon(Icons.ac_unit),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 16.0),
                child: Input(
                  placeholder: "Custom success",
                  borderColor: NowUIColors.success,
                  suffixIcon:
                      Icon(Icons.check_circle, color: NowUIColors.success),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 16.0),
                child: Input(
                  placeholder: "Custom error",
                  borderColor: NowUIColors.error,
                  suffixIcon: Icon(Icons.error, color: NowUIColors.error),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 8.0, top: 32, bottom: 32),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Switches",
                      style: TextStyle(
                          color: NowUIColors.text,
                          fontWeight: FontWeight.w600,
                          fontSize: 16)),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Switch is ON",
                      style: TextStyle(color: NowUIColors.text)),
                  Switch.adaptive(
                    value: switchValueOne,
                    onChanged: (bool newValue) =>
                        setState(() => switchValueOne = newValue),
                    activeColor: NowUIColors.primary,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Switch is OFF",
                      style: TextStyle(color: NowUIColors.text)),
                  Switch.adaptive(
                    value: switchValueTwo,
                    onChanged: (bool newValue) =>
                        setState(() => switchValueTwo = newValue),
                    activeColor: NowUIColors.primary,
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.only(left: 8.0, top: 32, bottom: 32),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Navigation",
                      style: TextStyle(
                          color: NowUIColors.text,
                          fontWeight: FontWeight.w600,
                          fontSize: 16)),
                ),
              ),
              const Navbar(
                title: "Regular",
                backButton: false,
              ),
              const Padding(
                padding: EdgeInsets.only(top: 16.0),
                child: Navbar(
                    title: "Custom",
                    backButton: true,
                    bgColor: NowUIColors.primary),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 16.0),
                child: Navbar(
                  title: "Categories",
                  searchBar: true,
                  backButton: true,
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 16.0),
                child: Navbar(
                  title: "Search",
                  searchBar: true,
                  backButton: true,
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 8.0, top: 32, bottom: 32),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Table Cell",
                      style: TextStyle(
                          color: NowUIColors.text,
                          fontWeight: FontWeight.w600,
                          fontSize: 16)),
                ),
              ),
              TableCellSettings(
                  title: "Manage Options in Settings",
                  onTap: () {
                    Navigator.pushReplacementNamed(context, '/settings');
                  }),
            ]),
          ),
        )));
  }
}
