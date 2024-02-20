import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graduation/theming/colors_manager.dart';

class RentingText extends StatelessWidget {
  final double fontSize;
  const RentingText({
    super.key, required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: GoogleFonts.inter(
          color: ColorsManager.navyBlue,
          fontWeight: FontWeight.w700,
          fontSize: fontSize,
        ),
        children: const [
          TextSpan(
            text: 'Renting',
          ),
          TextSpan(
            text: '.',
            style: TextStyle(
              color: ColorsManager.white,
            ),
          )
        ],
      ),
    );
  }
}