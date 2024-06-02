import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/theming/colors_manager.dart';
import 'package:graduation/views/profile_view/delete_account/data/delete_account_cubit.dart';
import 'package:graduation/views/profile_view/delete_account/data/delete_account_states.dart';
import 'package:graduation/views/sign_in/sign_in.dart';

class DeleteAccountDialog extends StatelessWidget {
  const DeleteAccountDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DeleteAccountCubit, DeleteAccountState>(
      listener: (context, state) {
        if (state is DeleteAccountSuccess) {
          // Handle successful account deletion
          Navigator.of(context).pop(); // Close the dialog
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SignInScreen()),
          );
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Account deleted successfully')),
          );
        } else if (state is DeleteAccountFailure) {
          // Handle failure
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      builder: (context, state) {
        return AlertDialog(
          backgroundColor: const Color.fromARGB(255, 216, 216, 216),
          title: const Text(
            'Delete Account',
            style: TextStyle(color: Color.fromARGB(255, 6, 101, 46)),
          ),
          content: const Text(
              'Are you sure you want to delete your account? This action cannot be undone.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Cancel',
                  style: TextStyle(color: Color.fromARGB(255, 6, 101, 46))),
            ),
            TextButton(
              onPressed: () {
                context.read<DeleteAccountCubit>().deleteAccount();
              },
              child: state is DeleteAccountLoading
                  ? const CircularProgressIndicator(
                      color: ColorsManager.mainGreen,
                    )
                  : const Text('Delete',
                      style: TextStyle(color: Color.fromARGB(255, 147, 18, 8))),
            ),
          ],
        );
      },
    );
  }
}
