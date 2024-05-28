import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/spacing/spacing.dart';
import 'package:graduation/theming/colors_manager.dart';
import 'package:graduation/views/edit_profile/data/edit_profile_cubit.dart';
import 'package:graduation/views/edit_profile/data/edit_profile_states.dart';
import 'package:graduation/views/profile_view/data/cubit/cubit/get_profile_info_cubit.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final firstNameController = TextEditingController();
    final lastNameController = TextEditingController();
    final emailController = TextEditingController();
    final phoneNumberController = TextEditingController();
    final addressController = TextEditingController();
    final usernameController = TextEditingController();

    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => GetProfileInfoCubit()..fetchProfileInfo()),
        BlocProvider(create: (context) => EditProfileCubit()),
      ],
      child: BlocListener<EditProfileCubit, EditProfileState>(
        listener: (context, state) {
          if (state is EditProfileSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Update done')),
            );
          } else if (state is EditProfileFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Failed to update')),
            );
          }
        },
        child: BlocBuilder<GetProfileInfoCubit, GetProfileInfoState>(
          builder: (context, state) {
            if (state is GetProfileInfoSuccess) {
              final profile = state.profileModel;
              firstNameController.text = profile.firstName;
              lastNameController.text = profile.lastName;
              emailController.text = profile.email;
              phoneNumberController.text = profile.phoneNumber;
              addressController.text = profile.address;
              usernameController.text = profile.username;

              return Scaffold(
                backgroundColor: ColorsManager.mainGreen,
                appBar: AppBar(
                  title: const Text('Edit Profile'),
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                ),
                body: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Form(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _buildCard('First Name', firstNameController),
                          _buildCard('Last Name', lastNameController),
                          _buildCard('Email', emailController),
                          _buildCard('Phone Number', phoneNumberController),
                          _buildCard('Address', addressController),
                          heightSpace(15),
                          ElevatedButton(
                            onPressed: () {
                              if (!phoneNumberController.text
                                  .startsWith('+2')) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          'Failed, you must add (+2) to your number')),
                                );
                              } else {
                                context.read<EditProfileCubit>().updateProfile(
                                      firstNameController.text,
                                      lastNameController.text,
                                      emailController.text,
                                      phoneNumberController.text,
                                      addressController.text,
                                      usernameController.text,
                                    );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor: ColorsManager.mainGreen,
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              ),
                            ),
                            child: const Text('Save Changes'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            } else if (state is GetProfileInfoLoading) {
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(
                    color: ColorsManager.mainGreen,
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

  Widget _buildCard(String label, TextEditingController controller) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                hintText: '',
                border: InputBorder.none,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
