import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graduation/mutual_widgets/custom_snack_bar.dart';
import 'package:graduation/mutual_widgets/elevated_button_for_sign_in_up.dart';
import 'package:graduation/mutual_widgets/repeated_text_field.dart';
import 'package:graduation/spacing/spacing.dart';
import 'package:graduation/theming/colors_manager.dart';
import 'package:graduation/views/add-apartments/cubit/add_apartment_cubit.dart';

class AddApartmentView extends StatelessWidget {
  AddApartmentView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocConsumer<AddApartmentCubit, AddApartmentState>(
        listener: (context, state) {
          if(state is AddApartmentSuccess){
            showCustomSnackbar(context, 'Success, your apartment added', ColorsManager.mainGreen);
          }
          else if(state is AddApartmentFailure){
            showCustomSnackbar(context, 'Failed', ColorsManager.red);
          }
        },
        builder: (context, state) {
          return Scaffold(
              body: Padding(
                padding: EdgeInsets.all(15),
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
                      RepeatedTextFormField(hintText: 'Enter title', controller: context.read<AddApartmentCubit>().titleText, hide: false),
                      heightSpace(15),
                      RepeatedTextFormField(hintText: 'Enter description', controller: context.read<AddApartmentCubit>().descriptionText, hide: false),
                      heightSpace(15),
                      RepeatedTextFormField(hintText: 'Enter address', controller: context.read<AddApartmentCubit>().addressText, hide: false),
                      heightSpace(15),
                      RepeatedTextFormField(hintText: 'Enter price', controller: context.read<AddApartmentCubit>().priceText, hide: false,keyboardType: TextInputType.number,),
                      heightSpace(15),
                      RepeatedTextFormField(hintText: 'Enter rooms', controller: context.read<AddApartmentCubit>().roomsText, hide: false,keyboardType: TextInputType.number,),
                      heightSpace(15),
                      RepeatedTextFormField(hintText: 'Enter size', controller: context.read<AddApartmentCubit>().sizeText, hide: false,keyboardType: TextInputType.number,),
                      heightSpace(15),
                      RepeatedTextFormField(hintText: 'Enter beds', controller: context.read<AddApartmentCubit>().bedsText, hide: false,keyboardType: TextInputType.number,),
                      heightSpace(15),
                      RepeatedTextFormField(hintText: 'Enter bathrooms', controller: context.read<AddApartmentCubit>().bathroomText, hide: false,keyboardType: TextInputType.number,),
                      heightSpace(15),
                      RepeatedTextFormField(hintText: 'Enter floor number', controller: context.read<AddApartmentCubit>().floorNumberText, hide: false,keyboardType: TextInputType.number,),
                      heightSpace(15),
                      RepeatedTextFormField(hintText: 'Enter finishing', controller: context.read<AddApartmentCubit>().finishingTypeText, hide: false),
                      heightSpace(15),
                      RepeatedTextFormField(hintText: 'Enter year of construction', controller: context.read<AddApartmentCubit>().yearOfConstructionText, hide: false,keyboardType: TextInputType.number,),
                      heightSpace(30),
                    ElevatedButtonForSignInUp(signInOrUp: 'Add apartment',
                    onPressed: (){
                      context.read<AddApartmentCubit>().addApartment();
                    },)
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
