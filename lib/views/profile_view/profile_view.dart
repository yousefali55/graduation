import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:graduation/spacing/spacing.dart';
import 'package:graduation/theming/colors_manager.dart';
import 'package:graduation/views/profile_view/change%20password/change_password.dart';
import 'package:graduation/views/profile_view/data/cubit/cubit/get_profile_info_cubit.dart';
import 'package:graduation/views/profile_view/delete_account/data/delete_account_cubit.dart';
import 'package:graduation/views/profile_view/delete_account/delete_account.dart';
import 'package:graduation/views/edit_profile/data/edit_profile_states.dart';
import 'package:graduation/views/edit_profile/edit_profile_view.dart';
import 'package:graduation/views/profile_view/contact%20us/contact_us.dart';
import 'package:graduation/views/profile_view/national_id/national_id_view.dart';
import 'package:graduation/views/profile_view/owner%20apartments/owner_apartments.dart';
import 'package:graduation/views/profile_view/profile_picture/profile_pic_cubit.dart';
import 'package:graduation/views/sign_in/sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  Future<bool> _isValidImageUrl(String url) async {
    try {
      final response = await http.head(Uri.parse(url));
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final ImagePicker picker = ImagePicker();

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => GetProfileInfoCubit()..fetchProfileInfo(),
        ),
        BlocProvider(
          create: (context) => ProfilePicCubit(),
        ),
        BlocProvider(
          create: (context) => DeleteAccountCubit(),
        ),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<ProfilePicCubit, EditProfileState>(
            listener: (context, state) {
              if (state is EditProfileSuccess) {
                context.read<GetProfileInfoCubit>().fetchProfileInfo();
              }
            },
          ),
          BlocListener<GetProfileInfoCubit, GetProfileInfoState>(
            listener: (context, state) {
              if (state is GetProfileInfoSuccess) {
                // Handle profile info update success if needed
              }
            },
          ),
        ],
        child: BlocBuilder<GetProfileInfoCubit, GetProfileInfoState>(
          builder: (context, state) {
            if (state is GetProfileInfoSuccess) {
              final profile = state.profileModel;
              return Scaffold(
                body: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Stack(
                        children: [
                          SizedBox(
                            width: 120,
                            height: 120,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: FutureBuilder<bool>(
                                future: _isValidImageUrl(profile.avatar ?? ''),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const Center(
                                      child: CircularProgressIndicator(
                                        color: ColorsManager.mainGreen,
                                      ),
                                    );
                                  } else if (snapshot.hasData &&
                                      snapshot.data == true) {
                                    return CachedNetworkImage(
                                      imageUrl: profile.avatar!,
                                      placeholder: (context, url) =>
                                          const Center(
                                        child: CircularProgressIndicator(
                                          color: ColorsManager.mainGreen,
                                        ),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          Image.asset(
                                        'images/avatar.jpg',
                                        fit: BoxFit.cover,
                                      ),
                                      fit: BoxFit.cover,
                                    );
                                  } else {
                                    return Image.asset(
                                      'images/avatar.jpg',
                                      fit: BoxFit.cover,
                                    );
                                  }
                                },
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: GestureDetector(
                              onTap: () async {
                                final XFile? pickedFile =
                                    await picker.pickImage(
                                  source: ImageSource.gallery,
                                  imageQuality: 50,
                                );

                                if (pickedFile != null) {
                                  File profilePicFile = File(pickedFile.path);
                                  context
                                      .read<ProfilePicCubit>()
                                      .updateProfilePic(profilePicFile);
                                }
                              },
                              child: Container(
                                width: 35,
                                height: 35,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: ColorsManager.mainGreen,
                                ),
                                child: const Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                  size: 20,
                                ),
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
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const EditProfileScreen(),
                              ),
                            );
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
                          title: 'Owner apartments',
                          icon: Icons.apartment,
                          onPress: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const OwnerApartmentsView()));
                          }),
                      ProfileMenuWidget(
                        color: ColorsManager.mainGreen,
                        title: 'Verify',
                        icon: Icons.verified,
                        onPress: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const SubmitNationalIdScreen()));
                        },
                      ),
                      ProfileMenuWidget(
                        color: ColorsManager.mainGreen,
                        title: 'Change Password',
                        icon: Icons.key_sharp,
                        onPress: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChangePasswordScreen()),
                          );
                        },
                      ),
                      ProfileMenuWidget(
                        color: ColorsManager.mainGreen,
                        title: 'Contact Us',
                        icon: Icons.contact_support,
                        onPress: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ContactUsScreen()),
                          );
                        },
                      ),
                      const Divider(),
                      ProfileMenuWidget(
                        color: const Color.fromARGB(255, 209, 17, 3),
                        title: 'Delete your account',
                        textColor: const Color.fromARGB(255, 209, 17, 3),
                        icon: Icons.delete_forever,
                        onPress: () {
                          showDialog(
                            context: context,
                            builder: (context) => const DeleteAccountDialog(),
                          );
                        },
                      ),
                      ProfileMenuWidget(
                        color: ColorsManager.mainGreen,
                        title: 'Logout',
                        icon: Icons.logout,
                        textColor: ColorsManager.mainGreen,
                        endIcon: false,
                        onPress: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignInScreen()),
                          );
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
