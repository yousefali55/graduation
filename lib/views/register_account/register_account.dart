import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:graduation/mutual_widgets/repeated_text_field.dart';
import 'package:graduation/mutual_widgets/texts_in_sign_in_up.dart';
import 'package:graduation/spacing/spacing.dart';
import 'package:graduation/theming/colors_manager.dart';
import 'package:graduation/views/register_account/data/cubit/register_with_upload_image_cubit.dart';

class RegisterAccountScreen extends StatelessWidget {
  final List<String> sellerOrBuyer;

  const RegisterAccountScreen({
    Key? key,
    required this.sellerOrBuyer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.mainGreen,
      body: Column(
        children: [
          Expanded(
            child: BlocConsumer<RegisterWithUploadImageCubit,
                RegisterWithUploadImageState>(
              listener: (context, state) {},
              builder: (context, state) {
                return Stack(
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
                              _buildDropdownButtonFormField(context),
                            ],
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

  Widget _buildDropdownButtonFormField(BuildContext context) {
    String? selectedSellerOrBuyer;
    return DropdownButtonFormField<String>(
      value: selectedSellerOrBuyer,
      items: sellerOrBuyer
          .map((who) => DropdownMenuItem(
                value: who,
                child: Text(who),
              ))
          .toList(),
      onChanged: (value) {
        _onSellerOrBuyerSelected(context, value);
      },
      decoration: InputDecoration(
        labelText: 'Choose seller or buyer?:',
        labelStyle: GoogleFonts.sora(
          color: ColorsManager.navyBlue,
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  void _onSellerOrBuyerSelected(BuildContext context, String? value) {
}
}
