import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graduation/theming/colors_manager.dart';

class ElevatedButtonForSignInUp extends StatelessWidget {
  final String signInOrUp;
  final void Function()? onPressed;
  const ElevatedButtonForSignInUp({
    super.key,
    required this.signInOrUp,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        backgroundColor: ColorsManager.mainGreen,
        minimumSize: const Size(400, 60),
      ),
      child: Text(
        signInOrUp,
        style: GoogleFonts.sora(
            color: ColorsManager.white,
            fontSize: 20,
            fontWeight: FontWeight.w300),
      ),
    );
  }
}
