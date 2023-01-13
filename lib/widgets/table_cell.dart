import 'package:flutter/material.dart';

class TableCellSettings extends StatelessWidget {
  final String title;
  final void Function()? onTap;
  const TableCellSettings({super.key, required this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: Theme.of(context).textTheme.button),
            const Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: Icon(Icons.arrow_forward_ios, size: 14),
            )
          ],
        ),
      ),
    );
  }
}
