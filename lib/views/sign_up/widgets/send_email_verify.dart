import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graduation/theming/colors_manager.dart';

void sendEmailVerifyAlertDialogue(BuildContext context,
    {required Function() onPressed}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: ColorsManager.white,
        title: Center(
          child: Text(
            'Verify your account',
            style: GoogleFonts.inter(
              color: ColorsManager.mainGreen,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        actions: [
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorsManager.mainGreen,
              ),
              onPressed: onPressed,
              child: Text(
                'Click here!',
                style: GoogleFonts.inter(
                  color: ColorsManager.primaryColor,
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ],
      );
    },
  );
}
