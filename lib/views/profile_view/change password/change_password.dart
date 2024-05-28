import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/theming/colors_manager.dart';
import 'package:graduation/mutual_widgets/custom_snack_bar.dart';
import 'package:graduation/mutual_widgets/repeated_text_field.dart';
import 'package:graduation/mutual_widgets/elevated_button_for_sign_in_up.dart';
import 'package:graduation/spacing/spacing.dart';
import 'package:graduation/views/profile_view/change%20password/data/change_password_cubit.dart';
import 'package:graduation/views/profile_view/change%20password/data/change_password_states.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation/mutual_widgets/texts_in_sign_in_up.dart';

class ChangePasswordScreen extends StatelessWidget {
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChangePasswordCubit(),
      child: BlocConsumer<ChangePasswordCubit, ChangePasswordState>(
        listener: (context, state) {
          if (state is ChangePasswordSuccess) {
            showCustomSnackbar(
              context,
              'Password changed successfully',
              ColorsManager.mainGreen,
            );
          } else if (state is ChangePasswordFailure) {
            showCustomSnackbar(
              context,
              state.error,
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
                          textWelcomeOrGetStarted: 'Change Password',
                        ),
                        heightSpace(16),
                        RepeatedTextFormField(
                          icon: const Icon(Icons.lock),
                          hide: true,
                          hintText: 'Enter current password',
                          controller: oldPasswordController,
                        ),
                        heightSpace(16),
                        RepeatedTextFormField(
                          icon: const Icon(Icons.lock_outline),
                          hide: true,
                          hintText: 'Enter new password',
                          controller: newPasswordController,
                        ),
                        heightSpace(16),
                        RepeatedTextFormField(
                          icon: const Icon(Icons.lock_outline),
                          hide: true,
                          hintText: 'Confirm new password',
                          controller: confirmPasswordController,
                        ),
                        heightSpace(80),
                        state is ChangePasswordLoading
                            ? const Center(
                                child: CircularProgressIndicator(
                                  color: ColorsManager.mainGreen,
                                ),
                              )
                            : ElevatedButtonForSignInUp(
                                signInOrUp: 'Change Password',
                                onPressed: () {
                                  final oldPassword =
                                      oldPasswordController.text;
                                  final newPassword =
                                      newPasswordController.text;
                                  final confirmPassword =
                                      confirmPasswordController.text;

                                  if (newPassword != confirmPassword) {
                                    showCustomSnackbar(
                                      context,
                                      'New password and confirmation do not match',
                                      ColorsManager.red,
                                    );
                                    return;
                                  }

                                  context
                                      .read<ChangePasswordCubit>()
                                      .changePassword(
                                        oldPassword,
                                        newPassword,
                                        confirmPassword,
                                      );
                                },
                              ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
