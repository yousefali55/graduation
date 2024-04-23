import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graduation/theming/colors_manager.dart';

class ForgetPasswordOrChangePassword extends StatelessWidget {
  final String forgetOrChange;
  final void Function()? onPressed;

  const ForgetPasswordOrChangePassword({super.key, required this.forgetOrChange, this.onPressed});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: onPressed,
          child: Text(
            forgetOrChange,
            style: GoogleFonts.sora(
              color: ColorsManager.mainGreen,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}