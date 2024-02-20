import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graduation/spacing/spacing.dart';
import 'package:graduation/theming/colors_manager.dart';

class TextInSignInUp extends StatelessWidget {
  final String textWelcomeOrGetStarted;
  const TextInSignInUp({super.key, required this.textWelcomeOrGetStarted});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Column(children: [
        heightSpace(20),
        Text(
          textWelcomeOrGetStarted,
          style: GoogleFonts.sora(
            color: ColorsManager.navyBlue,
            fontSize: 24,
            fontWeight: FontWeight.w600
          ),
        ),
        heightSpace(12),
        Text('Enter your details below',
        style: GoogleFonts.sora(
          color: ColorsManager.darkGrey,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),),
      ]),
    );
  }
}
