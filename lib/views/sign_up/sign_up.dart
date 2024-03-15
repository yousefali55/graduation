import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation/mutual_widgets/custom_snack_bar.dart';
import 'package:graduation/mutual_widgets/elevated_button_for_sign_in_up.dart';
import 'package:graduation/mutual_widgets/repeated_text_field.dart';
import 'package:graduation/mutual_widgets/texts_in_sign_in_up.dart';
import 'package:graduation/spacing/spacing.dart';
import 'package:graduation/theming/colors_manager.dart';
import 'package:graduation/views/on_board1/on_board1.dart';
import 'package:graduation/views/sign_in/data/cubit/sign_in_email_cubit.dart';
import 'package:graduation/views/sign_up/data/cubit/sign_up_email_cubit.dart';
import 'package:graduation/views/sign_up/widgets/send_email_verify.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.mainGreen,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 200.h,
            ),
            SizedBox(height: 20.h),
            BlocConsumer<SignUpEmailCubit, SignUpEmailState>(
              listener: (context, state) {
                if (state is SignUpEmailSuccess) {
                  showCustomSnackbar(
                      context, 'Success', ColorsManager.mainGreen);
                  sendEmailVerifyAlertDialogue(context, onPressed: () {
                    FirebaseAuth.instance.currentUser!.sendEmailVerification();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const OnBoardScreenI()),
                    );
                  });
                } else if (state is SignUpEmailFailure) {
                  showCustomSnackbar(context, 'Failed,${state.errorMessage}',
                      ColorsManager.red);
                }
              },
              builder: (context, state) {
                return Container(
                  height: 550,
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  decoration: const BoxDecoration(
                    color: ColorsManager.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                  child: Form(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const TextInSignInUp(
                            textWelcomeOrGetStarted: 'Create account'),
                        RepeatedTextFormField(
                            icon: const Icon(Icons.email),
                            hide: false,
                            hintText: 'Enter email',
                            controller: context
                                .read<SignUpEmailCubit>()
                                .emailController),
                        heightSpace(25),
                        RepeatedTextFormField(
                          icon: const Icon(Icons.key),
                          hide: true,
                          hintText: 'Enter password',
                          controller: context
                              .read<SignUpEmailCubit>()
                              .passwordController,
                        ),
                        heightSpace(28),
                        state is SignInEmailLaoding
                            ? const CircularProgressIndicator(
                                color: ColorsManager.mainGreen,
                              )
                            : ElevatedButtonForSignInUp(
                                signInOrUp: 'Sign Up',
                                onPressed: () {
                                  context
                                      .read<SignUpEmailCubit>()
                                      .signUpEmail();
                                },
                              ),
                        heightSpace(10),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
