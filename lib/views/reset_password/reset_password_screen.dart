import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation/mutual_widgets/custom_snack_bar.dart';
import 'package:graduation/mutual_widgets/elevated_button_for_sign_in_up.dart';
import 'package:graduation/mutual_widgets/repeated_text_field.dart';
import 'package:graduation/mutual_widgets/texts_in_sign_in_up.dart';
import 'package:graduation/spacing/spacing.dart';
import 'package:graduation/theming/colors_manager.dart';
import 'package:graduation/views/reset_password/cubit/reset_password_cubit.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ResetPasswordCubit, ResetPasswordState>(
      listener: (context, state) {
        if (state is ResetPasswordSuccess) {
          showCustomSnackbar(
            context,
            'Success',
            ColorsManager.mainGreen,
          );
        } else if (state is ResetPasswordFailure) {
          showCustomSnackbar(
            context,
            'failed,${state.errorMessage}',
            ColorsManager.red,
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: ColorsManager.mainGreen,
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 200.h),
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
                  child: Column(
                    children: [
                      const TextInSignInUp(
                          textWelcomeOrGetStarted: 'Reset Password'),
                      heightSpace(90),
                      RepeatedTextFormField(
                        hintText: 'Email',
                        controller: context
                            .read<ResetPasswordCubit>()
                            .emailTextEditingController,
                        hide: false,
                      ),
                      heightSpace(110),
                      ElevatedButtonForSignInUp(
                        signInOrUp: 'Reset !',
                        onPressed: () {
                          context
                              .read<ResetPasswordCubit>()
                              .requestPasswordChange();
                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
