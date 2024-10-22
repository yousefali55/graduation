import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/mutual_widgets/custom_snack_bar.dart';
import 'package:graduation/mutual_widgets/elevated_button_for_sign_in_up.dart';
import 'package:graduation/mutual_widgets/repeated_text_field.dart';
import 'package:graduation/mutual_widgets/texts_in_sign_in_up.dart';
import 'package:graduation/spacing/spacing.dart';
import 'package:graduation/theming/colors_manager.dart';
import 'package:graduation/views/sign_in/sign_in.dart';
import 'package:graduation/views/sign_up/data/cubit/sign_up_email_cubit.dart';
import 'package:graduation/views/sign_up/data/cubit/sign_up_email_state.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final signUpCubit = context.read<SignUpEmailCubit>();

    return Scaffold(
      backgroundColor: ColorsManager.mainGreen,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
          ),
          child: IntrinsicHeight(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 40),
                const SizedBox(height: 20),
                BlocConsumer<SignUpEmailCubit, SignUpEmailState>(
                  listener: (context, state) {
                    if (state is SignUpEmailSuccess) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Registration Done!'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                      signUpCubit.resetFields(); // Reset fields on success
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignInScreen(),
                        ),
                      );
                    } else if (state is SignUpEmailFailure) {
                      showCustomSnackbar(
                        context,
                        'Failed, ${state.errorMessage}',
                        ColorsManager.red,
                      );
                    }
                  },
                  builder: (context, state) {
                    return Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: const BoxDecoration(
                          color: ColorsManager.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40),
                          ),
                        ),
                        child: Form(
                          onChanged: () {
                            signUpCubit.checkPasswordMatch();
                            signUpCubit.checkFormValidity();
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const TextInSignInUp(
                                  textWelcomeOrGetStarted: 'Create account'),
                              RepeatedTextFormField(
                                hide: false,
                                hintText: 'First name',
                                controller: signUpCubit.firstnameController,
                              ),
                              heightSpace(10),
                              RepeatedTextFormField(
                                hide: false,
                                hintText: 'Last name',
                                controller: signUpCubit.lastnameController,
                              ),
                              heightSpace(10),
                              RepeatedTextFormField(
                                hide: false,
                                hintText: 'Username',
                                controller: signUpCubit.usernameController,
                              ),
                              heightSpace(10),
                              RepeatedTextFormField(
                                hide: false,
                                hintText: 'Email',
                                controller: signUpCubit.emailController,
                              ),
                              heightSpace(10),
                              RepeatedTextFormField(
                                hide: true,
                                hintText: 'Password',
                                controller: signUpCubit.passwordController,
                              ),
                              heightSpace(10),
                              RepeatedTextFormField(
                                hide: true,
                                hintText: 'Confirm password',
                                controller: signUpCubit.password2Controller,
                              ),
                              heightSpace(10),
                              DropdownButtonFormField<String>(
                                value: signUpCubit.userType,
                                items: const [
                                  DropdownMenuItem(
                                    value:
                                        '', // Change the value to an empty string or a unique value
                                    child: Text('Select User Type'),
                                  ),
                                  DropdownMenuItem(
                                    value: 'student',
                                    child: Text('Student'),
                                  ),
                                  DropdownMenuItem(
                                    value: 'owner',
                                    child: Text('Owner'),
                                  ),
                                ],
                                onChanged: (value) {
                                  signUpCubit.setUserType(value!);
                                },
                                decoration: InputDecoration(
                                  hintText: 'User type',
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                      color: ColorsManager.mainGreen,
                                      width: 1,
                                    ),
                                  ),
                                ),
                              ),
                              heightSpace(30),
                              state is SignUpEmailLoading
                                  ? const Center(
                                      child: CircularProgressIndicator(
                                        color: ColorsManager.mainGreen,
                                      ),
                                    )
                                  : ElevatedButtonForSignInUp(
                                      signInOrUp: 'Sign Up',
                                      onPressed:
                                          signUpCubit.isSignUpButtonEnabled()
                                              ? () {
                                                  signUpCubit.signUpEmail();
                                                }
                                              : null,
                                    ),
                              heightSpace(10),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      resizeToAvoidBottomInset: true,
    );
  }
}
