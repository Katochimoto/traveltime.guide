import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  final String? placeholder;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final void Function()? onTap;
  final void Function(String)? onChanged;
  final TextEditingController? controller;
  final bool autofocus;
  final Color? borderColor;

  const Input(
      {super.key,
      this.placeholder,
      this.suffixIcon,
      this.prefixIcon,
      this.onTap,
      this.onChanged,
      this.autofocus = false,
      this.borderColor,
      this.controller});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).inputDecorationTheme;
    return TextField(
      onTap: onTap,
      onChanged: onChanged,
      controller: controller,
      autofocus: autofocus,
      // style: const TextStyle(height: 20 / 15, fontSize: 15),
      // textAlignVertical: const TextAlignVertical(y: 0.6),
      decoration: InputDecoration(
        filled: true,
        fillColor: theme.fillColor,
        contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        // hintStyle: const TextStyle(height: 20 / 15, fontSize: 15),
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        hintText: placeholder,
      ),
    );
  }
}
