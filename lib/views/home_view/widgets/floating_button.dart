import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/views/add-apartments/add_apartment.dart';
import 'package:graduation/views/add-apartments/cubit/add_apartment_cubit.dart';

class HomeViewFloatingButton extends StatelessWidget {
  const HomeViewFloatingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => BlocProvider(
                      create: (context) => AddApartmentCubit(),
                      child: AddApartmentView(),
                    )));
      },
      backgroundColor: Colors.green,
      child: const Icon(Icons.add),
    );
  }
}
