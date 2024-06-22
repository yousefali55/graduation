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
            showCustomSnackbar(context, state.errorMessage, ColorsManager.red);
          }
        },
        builder: (context, state) {
          final cubit = context.read<AddApartmentCubit>();
          final selectedPhotos = cubit.selectedPhotos;
          final isLoading = state is AddApartmentLoading;

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
                    TextFormField(
                      maxLines: 6,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(17),
                        hintText: 'Enter description',
                        hintStyle: GoogleFonts.sora(
                          color: const Color.fromARGB(128, 36, 52, 67),
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                color: ColorsManager.darkGrey, width: 1)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                color: ColorsManager.mainGreen, width: 1)),
                      ),
                      controller: cubit.descriptionEnText,
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
                      hintText: 'Enter contact number',
                      controller: cubit.yearOfConstructionText,
                      hide: false,
                      keyboardType: TextInputType.number,
                    ),
                    heightSpace(15),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: ColorsManager.mainGreen),
                      onPressed: () async {
                        final ImagePicker picker = ImagePicker();
                        final List<XFile> photos =
                            await picker.pickMultiImage();

                        for (var photo in photos) {
                          cubit.addPhoto(File(photo.path));
                        }
                      },
                      child: const Text(
                        'Select Photos',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                    heightSpace(15),
                    selectedPhotos.isEmpty
                        ? const Text(
                            'No photos selected',
                            style: TextStyle(color: ColorsManager.mainGreen),
                          )
                        : SizedBox(
                            height: 200,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: selectedPhotos.length,
                              itemBuilder: (context, index) {
                                final photo = selectedPhotos[index];
                                return Stack(
                                  children: [
                                    Image.file(photo,
                                        width: 150,
                                        height: 150,
                                        fit: BoxFit.cover),
                                    Positioned(
                                      right: 0,
                                      child: IconButton(
                                        icon: const Icon(Icons.delete,
                                            color: Colors.red),
                                        onPressed: () =>
                                            cubit.removePhoto(photo),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                    heightSpace(20),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(
                            isLoading ? Colors.white : ColorsManager.mainGreen),
                        shape: WidgetStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        elevation: WidgetStateProperty.all(4),
                        shadowColor: WidgetStateProperty.all(Colors.black),
                      ),
                      onPressed: isLoading
                          ? null
                          : () {
                              cubit.addApartment();
                            },
                      child: isLoading
                          ? const CircularProgressIndicator(
                              color: ColorsManager.mainGreen,
                            )
                          : Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.add,
                                    color: Colors.white,
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    'Add Apartment',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                    ),
                    heightSpace(15),
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
