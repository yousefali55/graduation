import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/renting_app.dart';
import 'package:graduation/routing/app_router.dart';
import 'package:graduation/views/edit_profile/data/edit_profile_cubit.dart';
import 'package:graduation/views/home_view/data/cubit/get_apartments_cubit.dart';
import 'package:graduation/views/profile_view/data/cubit/cubit/get_profile_info_cubit.dart';
import 'package:graduation/views/sign_in/data/cubit/sign_in_email_cubit.dart';
import 'package:graduation/views/sign_up/data/cubit/sign_up_email_cubit.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<SignUpEmailCubit>(
          create: (_) => SignUpEmailCubit(),
        ),
        BlocProvider<GetApartmentsCubit>(
          create: (_) => GetApartmentsCubit(),
        ),
        BlocProvider<GetProfileInfoCubit>(
          create: (_) => GetProfileInfoCubit(),
        ),
        BlocProvider<SignInEmailCubit>(
          create: (_) => SignInEmailCubit(),
        ),
        BlocProvider<EditProfileCubit>(
          create: (_) => EditProfileCubit(),
        ),
      ],
      child: RentingApp(appRouter: AppRouter()),
    ),
  );
}
