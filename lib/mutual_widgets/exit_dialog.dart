import 'package:flutter/material.dart';

class ExitDialog extends StatelessWidget {
  const ExitDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final shouldPop = await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Do you want to exit the app?'),
            actions: [
              TextButton(
                child: const Text('No'),
                onPressed: () => Navigator.of(context).pop(false),
              ),
              TextButton(
                child: const Text('Yes'),
                onPressed: () => Navigator.of(context).pop(true),
              ),
            ],
          ),
        );

        return shouldPop ?? false;
      },
      child: const Scaffold(),
    );
  }
}
