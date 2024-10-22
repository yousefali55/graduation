import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/renting_app.dart';
import 'package:graduation/routing/app_router.dart';
import 'package:graduation/views/edit_profile/data/edit_profile_cubit.dart';
import 'package:graduation/views/home_view/data/cubit/get_apartments_cubit.dart';
import 'package:graduation/views/profile_view/data/cubit/cubit/get_profile_info_cubit.dart';
import 'package:graduation/views/profile_view/delete_account/data/delete_account_cubit.dart';
import 'package:graduation/views/profile_view/owner%20apartments/data/get_owner_apartments_cubit.dart';
import 'package:graduation/views/profile_view/owner%20apartments/delete%20apartments/delete_apartment_cubit.dart';
import 'package:graduation/views/profile_view/owner%20apartments/edit%20owner%20apartments/data/edit_owner_apartment_cubit.dart';
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
        BlocProvider<DeleteAccountCubit>(
          create: (_) => DeleteAccountCubit(),
        ),
        BlocProvider<GetOwnerApartmentsCubit>(
          create: (_) => GetOwnerApartmentsCubit(),
        ),
        BlocProvider<EditOwnerApartmentCubit>(
          create: (_) => EditOwnerApartmentCubit(),
        ),
        BlocProvider<DeleteOwnerApartmentCubit>(
          create: (_) => DeleteOwnerApartmentCubit(),
        ),
      ],
      child: RentingApp(appRouter: AppRouter()),
    ),
  );
}
