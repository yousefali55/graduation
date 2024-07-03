import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graduation/theming/colors_manager.dart';
import 'package:graduation/views/home_view/data/apartments_model.dart';
import 'package:graduation/views/profile_view/owner%20apartments/edit%20owner%20apartments/data/edit_owner_apartment_cubit.dart';
import 'package:graduation/views/profile_view/owner%20apartments/edit%20owner%20apartments/data/edit_owner_apartment_states.dart';

class EditOwnerApartmentView extends StatefulWidget {
  final ApartmentModel apartment;

  const EditOwnerApartmentView({super.key, required this.apartment});

  @override
  _EditOwnerApartmentViewState createState() => _EditOwnerApartmentViewState();
}

class _EditOwnerApartmentViewState extends State<EditOwnerApartmentView> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _addressController;
  late TextEditingController _priceController;
  late TextEditingController _roomsController;
  late TextEditingController _sizeController;
  late TextEditingController _bedsController;
  late TextEditingController _bathroomsController;
  late TextEditingController _floorNumberController;
  late TextEditingController _yearOfConstructionController;
  late TextEditingController _viewController;
  late TextEditingController _finishingTypeController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.apartment.titleEn);
    _descriptionController =
        TextEditingController(text: widget.apartment.description);
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
    _viewController = TextEditingController(text: widget.apartment.view);
    _finishingTypeController =
        TextEditingController(text: widget.apartment.finishingType);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _addressController.dispose();
    _priceController.dispose();
    _roomsController.dispose();
    _sizeController.dispose();
    _bedsController.dispose();
    _bathroomsController.dispose();
    _floorNumberController.dispose();
    _yearOfConstructionController.dispose();
    _viewController.dispose();
    _finishingTypeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: ColorsManager.white,
        title: Center(
          child: Text(
            'Edit Apartment',
            style: GoogleFonts.sora(
              color: ColorsManager.mainGreen,
              fontSize: 20.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      body: BlocListener<EditOwnerApartmentCubit, EditOwnerApartmentState>(
        listener: (context, state) {
          if (state is EditOwnerApartmentSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Apartment updated successfully'),
                backgroundColor: ColorsManager.mainGreen,
              ),
            );
          } else if (state is EditOwnerApartmentFailure) {
            if (state.errorMessage.contains('200')) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Apartment updated successfully'),
                  backgroundColor: ColorsManager.mainGreen,
                ),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.errorMessage)),
              );
            }
          }
        },
        child: BlocBuilder<EditOwnerApartmentCubit, EditOwnerApartmentState>(
          builder: (context, state) {
            if (state is EditOwnerApartmentLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  color: ColorsManager.mainGreen,
                ),
              );
            }

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildInputTextField(_titleController, 'Title'),
                  const SizedBox(height: 10),
                  _buildInputTextField(_addressController, 'Address'),
                  const SizedBox(height: 10),
                  _buildInputTextField(_priceController, 'Price'),
                  const SizedBox(height: 10),
                  _buildInputTextField(_roomsController, 'Rooms'),
                  const SizedBox(height: 10),
                  _buildInputTextField(_bathroomsController, 'Bathrooms'),
                  const SizedBox(height: 10),
                  _buildInputTextField(_bedsController, 'Beds'),
                  const SizedBox(height: 10),
                  _buildInputTextField(_sizeController, 'Size (sqft)'),
                  const SizedBox(height: 10),
                  _buildInputTextField(_floorNumberController, 'Floor Number'),
                  const SizedBox(height: 10),
                  _buildInputTextField(
                      _yearOfConstructionController, 'Year of Construction'),
                  const SizedBox(height: 10),
                  _buildInputTextField(_viewController, 'View'),
                  const SizedBox(height: 10),
                  _buildInputTextField(
                      _finishingTypeController, 'Finishing Type'),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _descriptionController,
                    decoration: const InputDecoration(
                      labelText: 'Description',
                      labelStyle:
                          TextStyle(color: Color.fromARGB(255, 8, 119, 54)),
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green),
                      ),
                    ),
                    maxLines: 5,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                    onPressed: () {
                      if (_titleController.text.isEmpty ||
                          _descriptionController.text.isEmpty ||
                          _addressController.text.isEmpty ||
                          _priceController.text.isEmpty ||
                          _roomsController.text.isEmpty ||
                          _sizeController.text.isEmpty ||
                          _bedsController.text.isEmpty ||
                          _bathroomsController.text.isEmpty ||
                          _floorNumberController.text.isEmpty ||
                          _yearOfConstructionController.text.isEmpty ||
                          _viewController.text.isEmpty ||
                          _finishingTypeController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            backgroundColor: Colors.red,
                            content: Text('Please, fill all fields'),
                          ),
                        );
                        return;
                      }

                      final updatedApartment = widget.apartment.copyWith(
                        titleEn: _titleController.text,
                        descriptionEn: _descriptionController.text,
                        address: _addressController.text,
                        price: double.tryParse(_priceController.text),
                        rooms: int.tryParse(_roomsController.text),
                        size: double.tryParse(_sizeController.text),
                        beds: int.tryParse(_bedsController.text),
                        bathrooms: int.tryParse(_bathroomsController.text),
                        floorNumber: int.tryParse(_floorNumberController.text),
                        yearOfConstruction:
                            int.tryParse(_yearOfConstructionController.text),
                        view: _viewController.text,
                        finishingType: _finishingTypeController.text,
                      );

                      context
                          .read<EditOwnerApartmentCubit>()
                          .updateApartment(updatedApartment);
                    },
                    child: const Text(
                      'Update Apartment',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildInputTextField(TextEditingController controller, String label) {
    return TextField(
      maxLines: 2,
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Color.fromARGB(255, 8, 119, 54)),
        border: const OutlineInputBorder(),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.green),
        ),
      ),
    );
  }
}
