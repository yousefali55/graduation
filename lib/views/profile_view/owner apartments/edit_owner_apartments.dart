import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/views/home_view/data/apartments_model.dart';
import 'package:graduation/views/profile_view/owner%20apartments/data/get_owner_apartments_cubit.dart';

class EditApartmentView extends StatefulWidget {
  final ApartmentModel apartment;

  const EditApartmentView({super.key, required this.apartment});

  @override
  _EditApartmentViewState createState() => _EditApartmentViewState();
}

class _EditApartmentViewState extends State<EditApartmentView> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _titleController;
  late TextEditingController _priceController;
  late TextEditingController _addressController;
  late TextEditingController _descriptionController;
  late TextEditingController _roomsController;
  late TextEditingController _sizeController;
  late TextEditingController _bedsController;
  late TextEditingController _bathroomsController;
  late TextEditingController _viewController;
  late TextEditingController _finishingTypeController;
  late TextEditingController _floorNumberController;
  late TextEditingController _yearOfConstructionController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.apartment.title);
    _priceController =
        TextEditingController(text: widget.apartment.price.toString());
    _addressController = TextEditingController(text: widget.apartment.address);
    _descriptionController =
        TextEditingController(text: widget.apartment.description);
    _roomsController =
        TextEditingController(text: widget.apartment.rooms.toString());
    _sizeController =
        TextEditingController(text: widget.apartment.size.toString());
    _bedsController =
        TextEditingController(text: widget.apartment.beds.toString());
    _bathroomsController =
        TextEditingController(text: widget.apartment.bathrooms.toString());
    _viewController = TextEditingController(text: widget.apartment.view);
    _finishingTypeController =
        TextEditingController(text: widget.apartment.finishingType);
    _floorNumberController =
        TextEditingController(text: widget.apartment.floorNumber.toString());
    _yearOfConstructionController = TextEditingController(
        text: widget.apartment.yearOfConstruction.toString());
  }

  @override
  void dispose() {
    _titleController.dispose();
    _priceController.dispose();
    _addressController.dispose();
    _descriptionController.dispose();
    _roomsController.dispose();
    _sizeController.dispose();
    _bedsController.dispose();
    _bathroomsController.dispose();
    _viewController.dispose();
    _finishingTypeController.dispose();
    _floorNumberController.dispose();
    _yearOfConstructionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Apartment')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextFormField(
                  controller: _titleController,
                  decoration: const InputDecoration(labelText: 'Title'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a title';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _priceController,
                  decoration: const InputDecoration(labelText: 'Price'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a price';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Please enter a valid number';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _addressController,
                  decoration: const InputDecoration(labelText: 'Address'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an address';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(labelText: 'Description'),
                  maxLines: null,
                ),
                TextFormField(
                  controller: _roomsController,
                  decoration: const InputDecoration(labelText: 'Rooms'),
                  keyboardType: TextInputType.number,
                ),
                TextFormField(
                  controller: _sizeController,
                  decoration: const InputDecoration(labelText: 'Size'),
                  keyboardType: TextInputType.number,
                ),
                TextFormField(
                  controller: _bedsController,
                  decoration: const InputDecoration(labelText: 'Beds'),
                  keyboardType: TextInputType.number,
                ),
                TextFormField(
                  controller: _bathroomsController,
                  decoration: const InputDecoration(labelText: 'Bathrooms'),
                  keyboardType: TextInputType.number,
                ),
                TextFormField(
                  controller: _viewController,
                  decoration: const InputDecoration(labelText: 'View'),
                ),
                TextFormField(
                  controller: _finishingTypeController,
                  decoration:
                      const InputDecoration(labelText: 'Finishing Type'),
                ),
                TextFormField(
                  controller: _floorNumberController,
                  decoration: const InputDecoration(labelText: 'Floor Number'),
                  keyboardType: TextInputType.number,
                ),
                TextFormField(
                  controller: _yearOfConstructionController,
                  decoration:
                      const InputDecoration(labelText: 'Year of Construction'),
                  keyboardType: TextInputType.number,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final updatedApartment = ApartmentModel(
                        id: widget.apartment.id,
                        photos: widget.apartment.photos,
                        ownerUsername: widget.apartment.ownerUsername,
                        ownerPhoneNumber: widget.apartment.ownerPhoneNumber,
                        ownerEmail: widget.apartment.ownerEmail,
                        title: _titleController.text,
                        titleEn: _titleController.text,
                        description: _descriptionController.text,
                        descriptionEn: _descriptionController.text,
                        address: _addressController.text,
                        price: double.parse(_priceController.text),
                        rooms: int.parse(_roomsController.text),
                        size: double.parse(_sizeController.text),
                        beds: int.parse(_bedsController.text),
                        bathrooms: int.parse(_bathroomsController.text),
                        view: _viewController.text,
                        finishingType: _finishingTypeController.text,
                        floorNumber: int.parse(_floorNumberController.text),
                        yearOfConstruction:
                            int.parse(_yearOfConstructionController.text),
                        owner: widget.apartment.owner,
                      );
                      context
                          .read<GetOwnerApartmentsCubit>()
                          .updateApartment(updatedApartment);
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Save Changes'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
