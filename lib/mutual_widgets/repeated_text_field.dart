import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graduation/theming/colors_manager.dart';

class RepeatedTextFormField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  const RepeatedTextFormField(
      {super.key,
      required this.hintText,
      required this.controller,
      });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(17),
        hintText: hintText,
        hintStyle: GoogleFonts.sora(
          color: ColorsManager.navyBlue,
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide:
                const BorderSide(color: ColorsManager.darkGrey, width: 1)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide:
                const BorderSide(color: ColorsManager.mainGreen, width: 1)),
      ),
    );
  }
}
