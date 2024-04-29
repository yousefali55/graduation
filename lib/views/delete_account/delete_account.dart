import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/theming/colors_manager.dart';
import 'package:graduation/views/delete_account/data/delete_account_cubit.dart';
import 'package:graduation/views/delete_account/data/delete_account_states.dart';

class DeleteAccountDialog extends StatelessWidget {
  const DeleteAccountDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<DeleteAccountCubit, DeleteAccountState>(
      listener: (context, state) {
        if (state is DeleteAccountFailure) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Error'),
              content: Text(state.message),
              actions: <Widget>[
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        } else if (state is DeleteAccountSuccess) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Success'),
              content: const Text('Account deleted successfully.'),
              actions: <Widget>[
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    // Navigate to login screen or any other screen as per your app flow
                  },
                ),
              ],
            ),
          );
        }
      },
      child: AlertDialog(
        title: const Text('Delete your account'),
        content: const Text(
            'Are you sure you want to delete your account? This action cannot be undone.'),
        actions: <Widget>[
          TextButton(
            child: const Text(
              'No',
              style: TextStyle(color: ColorsManager.mainGreen),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('Yes',
                style: TextStyle(color: ColorsManager.mainGreen)),
            onPressed: () {
              BlocProvider.of<DeleteAccountCubit>(context).deleteAccount();
            },
          ),
        ],
      ),
    );
  }
}
