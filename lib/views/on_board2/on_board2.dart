import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graduation/spacing/spacing.dart';
import 'package:graduation/theming/colors_manager.dart';
import 'package:graduation/views/home_view/home_view.dart';

class OnBoardScreenII extends StatelessWidget {
  const OnBoardScreenII({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Stack(children: [
          Image.asset('images/Rectangle 2.png'),
        ]),
        heightSpace(40),
        const Text(
          'New Place,New Home!',
          style: TextStyle(
              fontFamily: 'Inter', fontWeight: FontWeight.bold, fontSize: 22),
        ),
        heightSpace(20),
        const Padding(
          padding: EdgeInsets.only(left: 30.0, right: 20),
          child: Text(
            'Are you ready to uproot and start over in a new area? Renting System will help you on your journey.',
            style: TextStyle(fontFamily: 'Inter', fontSize: 15),
          ),
        ),
        heightSpace(70),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HomeView()),
            );
          },
          style: ElevatedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
            backgroundColor: ColorsManager.mainGreen,
            minimumSize: const Size(180, 50),
          ),
          child: Text(
            'Let' 's Start',
            style: GoogleFonts.sora(
                color: ColorsManager.white,
                fontSize: 20,
                fontWeight: FontWeight.w300),
          ),
        )
      ],
    ));
  }
}
