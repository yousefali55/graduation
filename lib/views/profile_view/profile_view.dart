import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graduation/spacing/spacing.dart';
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
              body: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Profile Image
                    Stack(
                      children: [
                        SizedBox(
                          width: 120,
                          height: 120,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.asset(
                              'images/logo circle.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            width: 35,
                            height: 35,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: ColorsManager.mainGreen,
                            ),
                            child: const Icon(
                              Icons.edit,
                              color: Colors.black,
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      profile.username,
                      style: GoogleFonts.sora(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: ColorsManager.navyBlue,
                      ),
                    ),
                    heightSpace(5),
                    Text(
                      profile.userType,
                      style: GoogleFonts.sora(
                        fontSize: 17,
                        color: const Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: 200,
                      child: ElevatedButton(
                        onPressed: () {
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorsManager.mainGreen,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: Text(
                          'Edit Profile',
                          style: GoogleFonts.sora(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Divider(),
                    ProfileMenuWidget(
                      color: ColorsManager.mainGreen,
                      title: 'Dark mode',
                      icon: Icons.dark_mode,
                      onPress: () {
                        // Handle Settings button press
                      },
                    ),
                    ProfileMenuWidget(
                      color: ColorsManager.mainGreen,
                      title: 'Contact Us',
                      icon: Icons.contact_support,
                      onPress: () {},
                    ),
                    ProfileMenuWidget(
                      color: ColorsManager.mainGreen,
                      title: 'Information',
                      icon: Icons.info,
                      onPress: () {
                        // Handle Information button press
                      },
                    ),
                    const Divider(),
                    ProfileMenuWidget(
                      color: const Color.fromARGB(255, 209, 17, 3),
                      title: 'Delete your account',
                      textColor: const Color.fromARGB(255, 209, 17, 3),
                      icon: Icons.delete_forever,
                      onPress: () {},
                    ),
                    ProfileMenuWidget(
                      color: ColorsManager.mainGreen,
                      title: 'Logout',
                      icon: Icons.logout,
                      textColor: ColorsManager.mainGreen,
                      endIcon: false,
                      onPress: () {
                      },
                    ),
                  ],
                ),
              ),
            );
          } else if (state is GetProfileInfoLoading) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(
                  valueColor:
                      AlwaysStoppedAnimation<Color>(ColorsManager.mainGreen),
                ),
              ),
            );
          } else if (state is GetProfileInfoFailure) {
            return Scaffold(
              appBar: AppBar(
                title: const Text('Error'),
              ),
              body: Center(
                child: Text(state.errorMessage), // Error message
              ),
            );
          } else {
            return Scaffold(
              appBar: AppBar(
                title: const Text('Unknown State'),
              ),
              body: const Center(
                child: Text('Unknown State'), // Default error message
              ),
            );
          }
        },
      ),
    );
  }
}

class ProfileMenuWidget extends StatelessWidget {
  const ProfileMenuWidget({
    super.key,
    required this.color,
    required this.title,
    required this.icon,
    required this.onPress,
    this.endIcon = true,
    this.textColor,
  });

  final String title;
  final IconData icon;
  final VoidCallback onPress;
  final bool endIcon;
  final Color? textColor;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPress,
      leading: Icon(
        icon,
        color: color,
      ),
      title: Text(
        title,
        style: GoogleFonts.sora(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: textColor ?? Colors.black,
        ),
      ),
      trailing: endIcon
          ? const Icon(
              Icons.arrow_forward_ios,
              size: 18,
              color: Colors.grey,
            )
          : null,
    );
  }
}
