import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/mutual_widgets/custom_snack_bar.dart';
import 'package:graduation/mutual_widgets/elevated_button_for_sign_in_up.dart';
import 'package:graduation/mutual_widgets/repeated_text_field.dart';
import 'package:graduation/mutual_widgets/texts_in_sign_in_up.dart';
import 'package:graduation/spacing/spacing.dart';
import 'package:graduation/theming/colors_manager.dart';
import 'package:graduation/views/home_view/data/cubit/get_apartments_cubit.dart';
import 'package:graduation/views/home_view/home_view.dart';
import 'package:graduation/views/sign_in/data/cubit/sign_in_email_cubit.dart';
import 'package:graduation/views/sign_in/data/cubit/sign_in_email_state.dart';
import 'package:graduation/views/sign_in/widgets/dont_have_account.dart';
import 'package:graduation/views/sign_in/widgets/forget_pawword.dart';
import 'package:graduation/views/sign_up/sign_up.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                listener: (context, state) {
                  if (state is SignInEmailSuccess) {
                    showCustomSnackbar(
                      context,
                      'Success',
                      ColorsManager.mainGreen,
                    );
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BlocProvider(
                          create: (context) => GetApartmentsCubit()..fetchApartments(),
                          child: const HomeView(),
                        ),
                      ),
                    );
                  } else if (state is SignInEmailFailure) {
                    showCustomSnackbar(
                      context,
                      _getErrorMessage(state.errorMessage),
                      ColorsManager.red,
                    );
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
                              // Implement your forgot password logic here
                              showDialog(
                                context: context,
                                builder: (_) =>
                                    const Text('Go Check The email'),
                              );
                            } catch (e) {
                              showCustomSnackbar(
                                context,
                                'Something wrong about ${e.toString()}, try again with correct email',
                                ColorsManager.red,
                              );
                            }
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
    );
  }

  String _getErrorMessage(String errorMessage) {
    if (errorMessage.contains("email")) {
      return "Email field must be unique";
    }
    return errorMessage;
  }
}
