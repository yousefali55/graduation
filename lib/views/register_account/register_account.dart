import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation/mutual_widgets/custom_snack_bar.dart';
import 'package:graduation/mutual_widgets/elevated_button_for_sign_in_up.dart';
import 'package:graduation/mutual_widgets/repeated_text_field.dart';
import 'package:graduation/mutual_widgets/texts_in_sign_in_up.dart';
import 'package:graduation/spacing/spacing.dart';
import 'package:graduation/theming/colors_manager.dart';
import 'package:graduation/views/apartments/apartments_screen.dart';
import 'package:graduation/views/register_account/data/cubit/register_with_upload_image_cubit.dart';
import 'package:graduation/views/register_account/widgets/upload_image_button.dart';

class RegisterAccountScreen extends StatelessWidget {
  const RegisterAccountScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterWithUploadImageCubit,
        RegisterWithUploadImageState>(
      listener: (context, state) {
        if (state is UploadImageSuccess) {
          showCustomSnackbar(
              context, 'Success ,continue your steps', ColorsManager.mainGreen);
        } else if (state is UploadImageFailure) {
          showCustomSnackbar(
              context, 'Failed for upload image, try again', ColorsManager.red);
        } else if (state is RegisterWithUploadImageSuccess) {
          showCustomSnackbar(context, 'Success', ColorsManager.mainGreen);
          Navigator.push(context,
              MaterialPageRoute(builder: (_) => const ApartmentsScreen()));
        } else if (state is RegisterWithUploadImageFailure) {
          showCustomSnackbar(context, 'Failed', ColorsManager.red);
        }
      },
      builder: (context, state) {
                Widget imageWidget = Container(); // Default empty container
        if (state is UploadImageSuccess && context.read<RegisterWithUploadImageCubit>().file!= null) {
          imageWidget = CircleAvatar(
            radius: 140,
            backgroundImage: FileImage(context.read<RegisterWithUploadImageCubit>().file!),
          );
        } else {
          imageWidget = const CircleAvatar(
            radius: 140,
            backgroundImage: AssetImage('assets/images/Unknown_person.jpg'),
          );
        }
        return Scaffold(
          backgroundColor: ColorsManager.mainGreen,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 240.h,
                child: Center(
                  child: SizedBox(
                    height: 260.h,
                    width: 190.w,
                    child: Stack(
                      children: [
                        Center(
                          child: imageWidget,
                        ),
                        Positioned(
                          right: 0,
                          bottom: 1,
                          child: state is RegisterWithUploadImageLoading
                              ? const CircularProgressIndicator(
                                  color: ColorsManager.mainGreen,
                                )
                              : ButtonUploadIamge(
                                  onTap: () {
                                    context
                                        .read<RegisterWithUploadImageCubit>()
                                        .uploadImage();
                                  },
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Stack(
                  children: [
                    Positioned(
                      right: 0,
                      left: 0,
                      bottom: 0,
                      child: Container(
                        height: 500.h,
                        decoration: const BoxDecoration(
                          color: ColorsManager.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            children: [
                              const TextInSignInUp(
                                  textWelcomeOrGetStarted: 'Create Profile'),
                              RepeatedTextFormField(
                                  hintText: 'Enter user name',
                                  controller: context
                                      .read<RegisterWithUploadImageCubit>()
                                      .userNameController),
                              heightSpace(20),
                              ElevatedButtonForSignInUp(
                                signInOrUp: 'Create',
                                onPressed: () {
                                  context
                                      .read<RegisterWithUploadImageCubit>()
                                      .registerAccount();
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
