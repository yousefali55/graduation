import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graduation/theming/colors_manager.dart';

void showCustomSnackbar(BuildContext context, String text, Color color) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        text,
        style: GoogleFonts.inter(
          fontSize: 15,
          color: ColorsManager.white,
          fontWeight: FontWeight.w400,
        ),
      ),
      backgroundColor: color,
    ),
  );
}
