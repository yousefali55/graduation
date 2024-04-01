import 'package:flutter/material.dart';
import 'package:graduation/routing/routes.dart';
import 'package:graduation/spacing/spacing.dart';
import 'package:graduation/theming/colors_manager.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    await Future.delayed(const Duration(seconds: 2));

    Navigator.pushNamed(context, Routes.signIn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            heightSpace(40),
            Image.asset(
              'images/logo circle.png',
              width: 250,
              height: 250,
            ),
            const SizedBox(height: 20),
            const Text(
              'RENTING APP',
              style: TextStyle(
                color: ColorsManager.mainGreen,
                fontFamily: 'Montserrat',
                fontSize: 35,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Please wait...',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 12,
                color: ColorsManager.mainGreen,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 50),
            const CircularProgressIndicator(
              valueColor:
                  AlwaysStoppedAnimation<Color>(ColorsManager.mainGreen),
            ),
            heightSpace(190),
            const Text('v1.0.0',
                style: TextStyle(color: ColorsManager.mainGreen))
          ],
        ),
      ),
    );
  }
}
