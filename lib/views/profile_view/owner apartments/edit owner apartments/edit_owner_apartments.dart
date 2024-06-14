import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/views/home_view/data/apartments_model.dart';
import 'package:graduation/views/profile_view/owner%20apartments/edit%20owner%20apartments/data/edit_owner_apartment_cubit.dart';
import 'package:graduation/views/profile_view/owner%20apartments/edit%20owner%20apartments/data/edit_owner_apartment_states.dart';

import '../../../../theming/colors_manager.dart';

class EditOwnerApartmentView extends StatefulWidget {
  final ApartmentModel apartment;

  const EditOwnerApartmentView({super.key, required this.apartment});

  @override
  _EditOwnerApartmentViewState createState() => _EditOwnerApartmentViewState();
}

class _EditOwnerApartmentViewState extends State<EditOwnerApartmentView> {
  late TextEditingController _titleController;
  late TextEditingController _addressController;
  late TextEditingController _priceController;
  late TextEditingController _roomsController;
  late TextEditingController _sizeController;
  late TextEditingController _bedsController;
  late TextEditingController _bathroomsController;
  late TextEditingController _floorNumberController;
  late TextEditingController _yearOfConstructionController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.apartment.title);
    _addressController = TextEditingController(text: widget.apartment.address);
    _priceController =
        TextEditingController(text: widget.apartment.price.toString());
    _roomsController =
        TextEditingController(text: widget.apartment.rooms.toString());
    _sizeController =
        TextEditingController(text: widget.apartment.size.toString());
    _bedsController =
        TextEditingController(text: widget.apartment.beds.toString());
    _bathroomsController =
        TextEditingController(text: widget.apartment.bathrooms.toString());
    _floorNumberController =
        TextEditingController(text: widget.apartment.floorNumber.toString());
    _yearOfConstructionController = TextEditingController(
        text: widget.apartment.yearOfConstruction.toString());
  }

  @override
  void dispose() {
    _titleController.dispose();
    _addressController.dispose();
    _priceController.dispose();
    _roomsController.dispose();
    _sizeController.dispose();
    _bedsController.dispose();
    _bathroomsController.dispose();
    _floorNumberController.dispose();
    _yearOfConstructionController.dispose();
    super.dispose();
  }

  void _updateApartment() {
    final cubit = context.read<EditOwnerApartmentCubit>();

    final updatedApartment = widget.apartment.copyWith(
      title: _titleController.text,
      address: _addressController.text,
      price: double.tryParse(_priceController.text) ?? 0,
      rooms: int.tryParse(_roomsController.text) ?? 0,
      size: double.tryParse(_sizeController.text) ?? 0,
      beds: int.tryParse(_bedsController.text) ?? 0,
      bathrooms: int.tryParse(_bathroomsController.text) ?? 0,
      floorNumber: int.tryParse(_floorNumberController.text) ?? 0,
      yearOfConstruction: int.tryParse(_yearOfConstructionController.text) ?? 0,
    );

    cubit.updateApartment(updatedApartment);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Apartment'),
        backgroundColor: ColorsManager.mainGreen,
      ),
      body: BlocListener<EditOwnerApartmentCubit, EditOwnerApartmentState>(
        listener: (context, state) {
          if (state is EditOwnerApartmentSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Apartment updated successfully!')),
            );
            Navigator.of(context).pop();
          } else if (state is EditOwnerApartmentFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text(
                      'Failed to update apartment: ${state.errorMessage}')),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: _addressController,
                decoration: const InputDecoration(labelText: 'Address'),
              ),
              TextField(
                controller: _priceController,
                decoration: const InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _roomsController,
                decoration: const InputDecoration(labelText: 'Rooms'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _sizeController,
                decoration: const InputDecoration(labelText: 'Size'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _bedsController,
                decoration: const InputDecoration(labelText: 'Beds'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _bathroomsController,
                decoration: const InputDecoration(labelText: 'Bathrooms'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _floorNumberController,
                decoration: const InputDecoration(labelText: 'Floor Number'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _yearOfConstructionController,
                decoration:
                    const InputDecoration(labelText: 'Year of Construction'),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _updateApartment,
                child: const Text('Update Apartment'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
