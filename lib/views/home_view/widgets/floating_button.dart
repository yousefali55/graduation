import 'package:flutter/material.dart';
import 'package:graduation/views/home_view/apartments/add_apartment.dart';

class HomeViewFloatingButton extends StatelessWidget {
  const HomeViewFloatingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return const AddApartmentDialog();
          },
        );
      },
      backgroundColor: Colors.green,
      child: const Icon(Icons.add),
    );
  }
}
