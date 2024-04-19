import 'package:flutter/material.dart';
import 'package:graduation/renting_app.dart';
import 'package:graduation/routing/app_router.dart';
import 'package:graduation/views/sign_up/data/cubit/sign_up_email_cubit.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        Provider<SignUpEmailCubit>(
          create: (_) => SignUpEmailCubit(),
        ),
      ],
      child: RentingApp(appRouter: AppRouter()),
    ),
  );
}
