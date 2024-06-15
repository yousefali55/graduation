import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graduation/mutual_widgets/custom_snack_bar.dart';
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
            showCustomSnackbar(context, 'Success, your apartment added',
                ColorsManager.mainGreen);
          } else if (state is AddApartmentFailure) {
            showCustomSnackbar(
                context, 'Failed: ${state.errorMessage}', ColorsManager.red);
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
                      controller: cubit.titleEnText,
                      hide: false,
                    ),
                    heightSpace(15),
                    RepeatedTextFormField(
                      hintText: 'Enter description ',
                      controller: cubit.descriptionEnText,
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
                    heightSpace(15),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: ColorsManager.mainGreen),
                      onPressed: () async {
                        final picker = ImagePicker();
                        final pickedFile = await picker.pickImage(
                          source: ImageSource.gallery,
                        );
                        if (pickedFile != null) {
                          cubit.addPhoto(File(pickedFile.path));
                        }
                      },
                      child: const Text(
                        'Select Photo',
                        style: TextStyle(color: ColorsManager.whityBlue),
                      ),
                    ),
                    heightSpace(15),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: ColorsManager.mainGreen),
                      onPressed: state is AddApartmentLoading
                          ? null
                          : () {
                              cubit.addApartment();
                            },
                      child: state is AddApartmentLoading
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : const Text(
                              'Submit',
                              style: TextStyle(color: ColorsManager.whityBlue),
                            ),
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
