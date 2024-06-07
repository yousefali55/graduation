import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graduation/mutual_widgets/custom_snack_bar.dart';
import 'package:graduation/mutual_widgets/elevated_button_for_sign_in_up.dart';
import 'package:graduation/mutual_widgets/repeated_text_field.dart';
import 'package:graduation/spacing/spacing.dart';
import 'package:graduation/theming/colors_manager.dart';
import 'package:graduation/views/add-apartments/cubit/add_apartment_cubit.dart';
import 'package:image_picker/image_picker.dart';

class AddApartmentView extends StatelessWidget {
  const AddApartmentView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocConsumer<AddApartmentCubit, AddApartmentState>(
        listener: (context, state) {
          if (state is AddApartmentSuccess) {
            showCustomSnackbar(
              context,
              'Success, your apartment added',
              ColorsManager.mainGreen,
            );
          } else if (state is AddApartmentFailure) {
            showCustomSnackbar(
              context,
              'Failed: ${state.errorMessage}',
              ColorsManager.red,
            );
          }
        },
        builder: (context, state) {
          final cubit = context.read<AddApartmentCubit>();
          final selectedPhoto = cubit.selectedPhoto;

          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(15),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    heightSpace(20),
                    Text(
                      'Add Apartment',
                      style: GoogleFonts.sora(
                        color: ColorsManager.mainGreen,
                        fontSize: 25,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    heightSpace(40),
                    RepeatedTextFormField(
                      hintText: 'Enter title',
                      controller: cubit.titleText,
                      hide: false,
                    ),
                    heightSpace(15),
                    RepeatedTextFormField(
                      hintText: 'Enter title (English)',
                      controller: cubit.titleEnText,
                      hide: false,
                    ),
                    heightSpace(15),
                    RepeatedTextFormField(
                      hintText: 'Enter title (Arabic)',
                      controller: cubit.titleArText,
                      hide: false,
                    ),
                    heightSpace(15),
                    RepeatedTextFormField(
                      hintText: 'Enter description',
                      controller: cubit.descriptionText,
                      hide: false,
                    ),
                    heightSpace(15),
                    RepeatedTextFormField(
                      hintText: 'Enter description (English)',
                      controller: cubit.descriptionEnText,
                      hide: false,
                    ),
                    heightSpace(15),
                    RepeatedTextFormField(
                      hintText: 'Enter description (Arabic)',
                      controller: cubit.descriptionArText,
                      hide: false,
                    ),
                    heightSpace(15),
                    RepeatedTextFormField(
                      hintText: 'Enter address',
                      controller: cubit.addressText,
                      hide: false,
                    ),
                    heightSpace(15),
                    RepeatedTextFormField(
                      hintText: 'Enter price',
                      controller: cubit.priceText,
                      hide: false,
                      keyboardType: TextInputType.number,
                    ),
                    heightSpace(15),
                    RepeatedTextFormField(
                      hintText: 'Enter rooms',
                      controller: cubit.roomsText,
                      hide: false,
                      keyboardType: TextInputType.number,
                    ),
                    heightSpace(15),
                    RepeatedTextFormField(
                      hintText: 'Enter size',
                      controller: cubit.sizeText,
                      hide: false,
                      keyboardType: TextInputType.number,
                    ),
                    heightSpace(15),
                    RepeatedTextFormField(
                      hintText: 'Enter beds',
                      controller: cubit.bedsText,
                      hide: false,
                      keyboardType: TextInputType.number,
                    ),
                    heightSpace(15),
                    RepeatedTextFormField(
                      hintText: 'Enter bathrooms',
                      controller: cubit.bathroomText,
                      hide: false,
                      keyboardType: TextInputType.number,
                    ),
                    heightSpace(15),
                    RepeatedTextFormField(
                      hintText: 'Enter view',
                      controller: cubit.viewText,
                      hide: false,
                    ),
                    heightSpace(15),
                    RepeatedTextFormField(
                      hintText: 'Enter finishing type',
                      controller: cubit.finishingTypeText,
                      hide: false,
                    ),
                    heightSpace(15),
                    RepeatedTextFormField(
                      hintText: 'Enter floor number',
                      controller: cubit.floorNumberText,
                      hide: false,
                      keyboardType: TextInputType.number,
                    ),
                    heightSpace(15),
                    RepeatedTextFormField(
                      hintText: 'Enter year of construction',
                      controller: cubit.yearOfConstructionText,
                      hide: false,
                      keyboardType: TextInputType.number,
                    ),
                    heightSpace(15),
                    RepeatedTextFormField(
                      hintText: 'Enter owner username',
                      controller: cubit.ownerUsernameText,
                      hide: false,
                    ),
                    heightSpace(15),
                    RepeatedTextFormField(
                      hintText: 'Enter owner phone number',
                      controller: cubit.ownerPhoneNumberText,
                      hide: false,
                    ),
                    heightSpace(15),
                    RepeatedTextFormField(
                      hintText: 'Enter owner email',
                      controller: cubit.ownerEmailText,
                      hide: false,
                    ),
                    heightSpace(15),
                    if (selectedPhoto != null)
                      Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                        ),
                        child: Stack(
                          children: [
                            Image.file(
                              selectedPhoto,
                              fit: BoxFit.cover,
                            ),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () {
                                  cubit.removePhoto();
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    heightSpace(20),
                    if (selectedPhoto == null)
                      TextButton.icon(
                        icon: const Icon(Icons.photo_camera),
                        label: const Text('Add Photo'),
                        onPressed: () async {
                          final ImagePicker picker = ImagePicker();
                          final XFile? pickedFile = await picker.pickImage(
                            source: ImageSource.gallery,
                          );

                          if (pickedFile != null) {
                            cubit.addPhoto(File(pickedFile.path));
                          }
                        },
                      ),
                    heightSpace(20),
                    (state is AddApartmentLoading)
                        ? const CircularProgressIndicator()
                        : ElevatedButtonForSignInUp(
                            signInOrUp: 'Add apartment',
                            onPressed: () {
                              cubit.addApartment();
                            },
                          ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
