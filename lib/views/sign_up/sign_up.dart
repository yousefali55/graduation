import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graduation/mutual_widgets/custom_snack_bar.dart';
import 'package:graduation/mutual_widgets/elevated_button_for_sign_in_up.dart';
import 'package:graduation/mutual_widgets/repeated_text_field.dart';
import 'package:graduation/mutual_widgets/texts_in_sign_in_up.dart';
import 'package:graduation/spacing/spacing.dart';
import 'package:graduation/theming/colors_manager.dart';
import 'package:graduation/views/sign_in/data/cubit/sign_in_email_cubit.dart';
import 'package:graduation/views/sign_up/data/cubit/sign_up_email_cubit.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.mainGreen,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: BlocConsumer<SignUpEmailCubit, SignUpEmailState>(
              listener: (context, state) {
                if (state is SignUpEmailSuccess) {
                  showCustomSnackbar(
                      context, 'Success', ColorsManager.mainGreen);
                } else if (state is SignUpEmailFailure) {
                  showCustomSnackbar(context, 'Failed,${state.errorMessage}',
                      ColorsManager.red);
                }
              },
              builder: (context, state) {
                return Stack(
                  children: [
                    Positioned(
                      right: 0,
                      left: 0,
                      bottom: 0,
                      child: Container(
                        height: 540.h,
                        decoration: const BoxDecoration(
                          color: ColorsManager.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40),
                          ),
                        ),
                        child: Form(
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Column(
                              children: [
                                const TextInSignInUp(
                                    textWelcomeOrGetStarted: 'Create account'),
                                RepeatedTextFormField(
                                    hintText: 'Enter email',
                                    controller: context
                                        .read<SignUpEmailCubit>()
                                        .emailController),
                                heightSpace(25),
                                RepeatedTextFormField(
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
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
