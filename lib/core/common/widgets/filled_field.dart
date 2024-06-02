import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../res/colours.dart';

class FilledField extends StatelessWidget {
  const FilledField({
    super.key,
    this.readOnly = false,
    this.controller,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.keyboardType,
    this.hintStyle,
  });

  final TextEditingController? controller;
  final bool readOnly;
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final TextStyle? hintStyle;

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(16),
    );
    return TextField(
      keyboardType: keyboardType,
      style: GoogleFonts.poppins(
        fontSize: 18,
        color: Colours.darkBackground,
        fontWeight: FontWeight.bold,
      ),
      controller: controller,
      readOnly: readOnly,
      onTapOutside: (_) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      decoration: InputDecoration(
        filled: true,
        fillColor: Colours.light,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        hintText: hintText,
        hintStyle: hintStyle,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 5,
        ),
        focusedBorder: border,
        enabledBorder: border,
      ),
    );
  }
}
