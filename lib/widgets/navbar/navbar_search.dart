import 'package:flutter/material.dart';
import 'package:traveltime/constants/theme.dart';
import 'package:traveltime/widgets/input.dart';

@immutable
class NavbarSearch extends Input {
  const NavbarSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: UINavbar.hSearch,
      child: Input(
          placeholder: "What are you looking for?",
          controller: controller,
          onChanged: onChanged,
          autofocus: autofocus,
          suffixIcon: const Icon(
            Icons.search,
            size: 20,
          ),
          onTap: () {
            // if (!isOnSearch)
            //   Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //           builder: (context) => Search()));
          }),
    );
  }
}
