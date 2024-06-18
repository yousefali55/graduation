import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:graduation/routing/routes.dart'; // Make sure to replace with your actual import
import 'package:graduation/spacing/spacing.dart';
import 'package:graduation/theming/colors_manager.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final LocalAuthentication auth = LocalAuthentication();
  bool _appClosed = false; // Add this variable to track app closure

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);

    try {
      if (_appClosed) {
        // Check if app was closed
        _appClosed = false; // Reset app closed flag
        Navigator.pushReplacementNamed(context, Routes.signIn);
        return; // Exit method early
      }

      bool isAuthenticated = await auth.authenticate(
        localizedReason: 'Authenticate to proceed',
      );

      if (isAuthenticated) {
        await Future.delayed(const Duration(seconds: 2));
        Navigator.pushReplacementNamed(context, Routes.signIn);
      } else {
        print('Biometric authentication failed.');
        _exitApp();
      }
    } on PlatformException catch (e) {
      print('Error during biometric authentication: $e');
      _exitApp();
    }

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
  }

  void _exitApp() {
    _appClosed = true; // Set app closed flag
    SystemNavigator.pop();
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
