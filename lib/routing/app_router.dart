import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/routing/routes.dart';
import 'package:graduation/views/reset_password/reset_password_screen.dart';
import 'package:graduation/views/reset_password/cubit/reset_password_cubit.dart';
import 'package:graduation/views/sign_in/data/cubit/sign_in_email_cubit.dart';
import 'package:graduation/views/sign_in/sign_in.dart';
import 'package:graduation/views/sign_up/data/cubit/sign_up_email_cubit.dart';
import 'package:graduation/views/sign_up/sign_up.dart';
import 'package:graduation/views/splash%20screen/splash_screen.dart';

class AppRouter {
  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splash: // Define the route for the splash screen
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(), // Use the splash screen widget
        );
      case Routes.signIn:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => SignInEmailCubit(),
            child: const SignInScreen(),
          ),
        );
      case Routes.signUp:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => SignUpEmailCubit(),
            child: const SignUpScreen(),
          ),
        );
      case Routes.changePassword:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => ResetPasswordCubit(),
            child: const ResetPasswordScreen(),
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(),
        );
    }
  }
}
