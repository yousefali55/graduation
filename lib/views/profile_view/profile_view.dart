import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graduation/theming/colors_manager.dart';
import 'package:graduation/views/profile_view/data/cubit/cubit/get_profile_info_cubit.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetProfileInfoCubit()..fetchProfileInfo(),
      child: BlocBuilder<GetProfileInfoCubit, GetProfileInfoState>(
        builder: (context, state) {
          print("Current state: ${state.runtimeType}");
          if (state is GetProfileInfoSuccess) {
            final profile = state.profileModel;
            return Scaffold(
              body: Column(
                children: [
                  SizedBox(
                      height: MediaQuery.of(context)
                          .padding
                          .top), // Top padding for status bar
                  Center(
                    child: Column(
                      children: [
                        const CircleAvatar(
                          radius: 70,
                          // Replace with your avatar image or network image URL
                          backgroundImage: AssetImage('assets/avatar.png'),
                        ),
                        const SizedBox(height: 15),
                        Text(
                          profile.username, // Display username
                          style: GoogleFonts.sora(
                            color: ColorsManager.navyBlue,
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Opacity(
                          opacity: 0.5,
                          child: Text(
                            profile.email, // Display email
                            style: GoogleFonts.sora(
                              color: ColorsManager.offWhite,
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else if (state is GetProfileInfoLoading) {
            return const Center(
              child: CircularProgressIndicator(), // Loading state
            );
          } else if (state is GetProfileInfoFailure) {
            return Center(
              child: Text(state.errorMessage), // Error message
            );
          } else {
            return const Center(
              child: Text('Unknown State'), // Default error message
            );
          }
        },
      ),
    );
  }
}
