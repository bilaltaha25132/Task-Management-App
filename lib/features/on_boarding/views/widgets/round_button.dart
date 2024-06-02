import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/core/res/colours.dart';

class RoundButton extends StatelessWidget {
  const RoundButton(
      {required this.text,
      this.onPressed,
      super.key,
      this.backgroundColour,
      this.borderColour});

  final VoidCallback? onPressed;
  final String text;
  final Color? backgroundColour;
  final Color? borderColour;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColour ?? Colours.light,
        minimumSize: Size(size.width * .9, size.height * .06),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: borderColour == null
              ? BorderSide.none
              : BorderSide(color: borderColour!),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: GoogleFonts.poppins(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: borderColour ?? Colours.darkBackground,
        ),
      ),
    );
  }
}
