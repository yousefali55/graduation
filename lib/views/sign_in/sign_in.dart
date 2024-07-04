import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/mutual_widgets/custom_snack_bar.dart';
import 'package:graduation/mutual_widgets/elevated_button_for_sign_in_up.dart';
import 'package:graduation/mutual_widgets/repeated_text_field.dart';
import 'package:graduation/mutual_widgets/texts_in_sign_in_up.dart';
import 'package:graduation/routing/routes.dart';
import 'package:graduation/spacing/spacing.dart';
import 'package:graduation/theming/colors_manager.dart';
import 'package:graduation/views/home_view/data/cubit/get_apartments_cubit.dart';
import 'package:graduation/views/home_view/home_view.dart';
import 'package:graduation/views/profile_view/data/cubit/cubit/get_profile_info_cubit.dart';
import 'package:graduation/views/sign_in/data/cubit/sign_in_email_cubit.dart';
import 'package:graduation/views/sign_in/data/cubit/sign_in_email_state.dart';
import 'package:graduation/views/sign_in/widgets/dont_have_account.dart';
import 'package:graduation/views/sign_in/widgets/forget_pawword.dart';
import 'package:graduation/views/sign_up/sign_up.dart';
import 'package:flutter/services.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final shouldPop = await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Do you want to exit the app?'),
            actions: [
              TextButton(
                child: const Text('No'),
                onPressed: () => Navigator.of(context).pop(false),
              ),
              TextButton(
                child: const Text('Yes'),
                onPressed: () {
                  SystemNavigator.pop();
                },
              ),
            ],
          ),
        );

        return shouldPop ?? false;
      },
      child: BlocProvider(
        create: (context) => SignInEmailCubit(),
        child: Scaffold(
          backgroundColor: ColorsManager.mainGreen,
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(
                    height: 190,
                    child: Image(image: AssetImage('images/logo circle.png'))),
                const SizedBox(height: 25),
                Container(
                  height: MediaQuery.of(context).size.height - 220,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: const BoxDecoration(
                    color: ColorsManager.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                  child: BlocConsumer<SignInEmailCubit, SignInEmailState>(
                    listener: (context, state) async {
                      if (state is SignInEmailSuccess) {
                        final profileCubit = GetProfileInfoCubit()
                          ..fetchProfileInfo();
                        profileCubit.stream.listen((profileState) {
                          if (profileState is GetProfileInfoSuccess) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MultiBlocProvider(
                                  providers: [
                                    BlocProvider.value(
                                      value: profileCubit,
                                    ),
                                    BlocProvider(
                                      create: (context) => GetApartmentsCubit()
                                        ..fetchApartments(),
                                    ),
                                  ],
                                  child: HomeView(
                                      userType:
                                          profileState.profileModel.userType),
                                ),
                              ),
                            );
                          } else if (profileState is GetProfileInfoFailure) {
                            showCustomSnackbar(context,
                                profileState.errorMessage, ColorsManager.red);
                          }
                        });
                      } else if (state is SignInEmailFailure) {
                        showCustomSnackbar(
                            context, state.errorMessage, ColorsManager.red);
                      }
                    },
                    builder: (context, state) {
                      return Form(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const TextInSignInUp(
                              textWelcomeOrGetStarted: 'Welcome back!',
                            ),
                            RepeatedTextFormField(
                              icon: const Icon(Icons.person),
                              hide: false,
                              hintText: 'Enter username',
                              controller: context
                                  .read<SignInEmailCubit>()
                                  .usernameController,
                            ),
                            heightSpace(25),
                            PasswordTextFormField(
                              controller: context
                                  .read<SignInEmailCubit>()
                                  .passwordController,
                            ),
                            heightSpace(8),
                            ForgetPasswordOrChangePassword(
                              forgetOrChange: 'Forget Password?',
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, Routes.changePassword);
                              },
                            ),
                            heightSpace(20),
                            state is SignInEmailLoading
                                ? const Center(
                                    child: CircularProgressIndicator(
                                      color: ColorsManager.mainGreen,
                                    ),
                                  )
                                : ElevatedButtonForSignInUp(
                                    signInOrUp: 'Sign In',
                                    onPressed: () {
                                      context
                                          .read<SignInEmailCubit>()
                                          .signInEmail();
                                    },
                                  ),
                            heightSpace(20),
                            DontHaveAccount(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const SignUpScreen(),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
