import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/routing/routes.dart';
import 'package:graduation/views/register_account/data/cubit/register_with_upload_image_cubit.dart';
import 'package:graduation/views/register_account/register_account.dart';
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
          ),
        );
      case Routes.registerAccount:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => RegisterWithUploadImageCubit(),
            child: RegisterAccountScreen(
              sellerOrBuyer: const [],
            ),
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Text('No Routing'),
          ),
        );
    }
  }
}
