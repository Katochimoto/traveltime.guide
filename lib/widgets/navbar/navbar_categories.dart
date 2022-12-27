import 'package:flutter/material.dart';
import 'package:teamtravel/constants/Theme.dart';

@immutable
class NavbarCategories extends StatelessWidget {
  const NavbarCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: UINavbar.hCategories,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) => Trending()));
            },
            child: Row(
              children: const [
                Icon(Icons.camera, color: NowUIColors.text, size: 18.0),
                SizedBox(width: 8),
                Text("asdasd",
                    style: TextStyle(color: NowUIColors.text, fontSize: 14.0)),
              ],
            ),
          ),
          const SizedBox(width: 30),
          Container(
            color: NowUIColors.text,
            height: 25,
            width: 1,
          ),
          const SizedBox(width: 30),
          GestureDetector(
            onTap: () {
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) => Fashion()));
            },
            child: Row(
              children: const [
                Icon(Icons.shopping_cart, color: NowUIColors.text, size: 18.0),
                SizedBox(width: 8),
                Text("dadasdasd",
                    style: TextStyle(color: NowUIColors.text, fontSize: 14.0)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
