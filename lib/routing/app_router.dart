import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/routing/routes.dart';
import 'package:graduation/views/sign_in/data/cubit/sign_in_email_cubit.dart';
import 'package:graduation/views/sign_in/sign_in.dart';
import 'package:graduation/views/sign_up/data/cubit/sign_up_email_cubit.dart';
import 'package:graduation/views/sign_up/sign_up.dart';

class AppRouter {
  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
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
                ));
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Text('No Routing'),
          ),
        );
    }
  }
}
