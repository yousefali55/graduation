import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graduation/spacing/spacing.dart';
import 'package:graduation/theming/colors_manager.dart';
import 'package:graduation/views/home_view/home_view.dart';
import 'package:graduation/views/on_board2/on_board2.dart';

class OnBoardScreenI extends StatelessWidget {
  const OnBoardScreenI({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Stack(children: [
          Image.asset('images/Rectangle 1.png'),
          Positioned(
              top: 8,
              right: 8,
              child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const HomeView()),
                    );
                  },
                  child: const Text(
                    'Skip',
                    style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                        color: Colors.black),
                  )))
        ]),
        heightSpace(40),
        const Text(
          'Find your perfect home!',
          style: TextStyle(
              fontFamily: 'Inter', fontWeight: FontWeight.bold, fontSize: 22),
        ),
        heightSpace(20),
        const Padding(
          padding: EdgeInsets.only(left: 30.0, right: 20),
          child: Text(
            'Filter by furnishig, location, number of room and price & reach the seller directly!',
            style: TextStyle(fontFamily: 'Inter', fontSize: 15),
          ),
        ),
        heightSpace(70),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const OnBoardScreenII()),
            );
          },
          style: ElevatedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
            backgroundColor: ColorsManager.mainGreen,
            minimumSize: const Size(180, 50),
          ),
          child: Text(
            'Next',
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
