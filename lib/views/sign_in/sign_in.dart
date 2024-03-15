import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation/mutual_widgets/custom_snack_bar.dart';
import 'package:graduation/mutual_widgets/elevated_button_for_sign_in_up.dart';
import 'package:graduation/mutual_widgets/repeated_text_field.dart';
import 'package:graduation/mutual_widgets/texts_in_sign_in_up.dart';
import 'package:graduation/routing/routes.dart';
import 'package:graduation/spacing/spacing.dart';
import 'package:graduation/theming/colors_manager.dart';
import 'package:graduation/views/sign_in/data/cubit/sign_in_email_cubit.dart';
import 'package:graduation/views/sign_in/widgets/dont_have_account.dart';
import 'package:graduation/views/sign_in/widgets/forget_pawword.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          SystemNavigator.pop();
          return false;
        },
        child: Scaffold(
          backgroundColor: ColorsManager.mainGreen,
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: 190.h,
                  child: Image.asset(
                    'images/logo circle.png',
                  ),
                ),
                SizedBox(height: 25.h),
                Container(
                  height: MediaQuery.of(context).size.height - 220.h,
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  decoration: const BoxDecoration(
                    color: ColorsManager.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                  child: BlocConsumer<SignInEmailCubit, SignInEmailState>(
                    listener: (context, state) {
                      if (state is SignInEmailSuccess) {
                        showCustomSnackbar(
                            context, 'Success', ColorsManager.mainGreen);
                      } else if (state is SignInEmailFailure) {
                        showCustomSnackbar(context,
                            'Failed,${state.errorMessage}', ColorsManager.red);
                      }
                    },
                    builder: (context, state) {
                      return Form(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const TextInSignInUp(
                                textWelcomeOrGetStarted: 'Welcome back!'),
                            RepeatedTextFormField(
                              icon: const Icon(Icons.email),
                              hide: false,
                              hintText: 'Enter email',
                              controller: context
                                  .read<SignInEmailCubit>()
                                  .emailController,
                            ),
                            heightSpace(25),
                            RepeatedTextFormField(
                              icon: const Icon(Icons.key),
                              hide: true,
                              hintText: 'Enter password',
                              controller: context
                                  .read<SignInEmailCubit>()
                                  .passwordController,
                            ),
                            heightSpace(8),
                            ForgetPassword(
                              onPressed: () async {
                                try {
                                  await FirebaseAuth.instance
                                      .sendPasswordResetEmail(
                                          email: context
                                              .read<SignInEmailCubit>()
                                              .emailController
                                              .text);
                                  showDialog(
                                      context: context,
                                      builder: (_) =>
                                          const Text('Go Check The email'));
                                } catch (e) {
                                  showCustomSnackbar(
                                      context,
                                      'Something wrong about ${e.toString()}, try again with correct email',
                                      ColorsManager.red);
                                }
                              },
                            ),
                            heightSpace(20),
                            state is SignInEmailLaoding
                                ? const CircularProgressIndicator(
                                    color: ColorsManager.mainGreen,
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
                                Navigator.pushNamed(context, Routes.signUp);
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
        ));
  }
}
