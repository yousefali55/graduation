import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graduation/views/profile_view/national_id/data/image_verify_service.dart';
import 'package:graduation/views/profile_view/national_id/data/national_id_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:graduation/theming/colors_manager.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:intl/intl.dart';

class SubmitNationalIdScreen extends StatefulWidget {
  const SubmitNationalIdScreen({super.key});

  @override
  _SubmitNationalIdScreenState createState() => _SubmitNationalIdScreenState();
}

class _SubmitNationalIdScreenState extends State<SubmitNationalIdScreen> {
  final _formKey = GlobalKey<FormState>();
  final _birthDateController = TextEditingController();
  final _birthGovernorateController = TextEditingController();
  final _genderController = TextEditingController();
  final _nationalIdController = TextEditingController();
  File? _image;
  bool _isLoading = false;

  Future<void> _pickImage() async {
    if (_isLoading) return; // Prevent multiple clicks

    setState(() => _isLoading = true);

    try {
      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() => _image = File(pickedFile.path));
      }
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<File?> compressImage(File image) async {
    final dir = await getTemporaryDirectory();
    final targetPath = path.join(
        dir.absolute.path, "${DateTime.now().millisecondsSinceEpoch}.jpg");

    final XFile? result = await FlutterImageCompress.compressAndGetFile(
      image.absolute.path,
      targetPath,
      quality: 30, // Reduce quality further
    );

    if (result != null) {
      return File(result.path);
    } else {
      return null;
    }
  }

  Future<void> _submitNationalId() async {
    if (_formKey.currentState!.validate() && _image != null) {
      setState(() => _isLoading = true);
      try {
        final File? compressedImage = await compressImage(_image!);
        if (compressedImage == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Failed to compress image.'),
            ),
          );
          return;
        }

        final isReal =
            await ImageVerificationService().verifyImage(compressedImage);
        if (!isReal) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('The uploaded image is not valid.'),
            ),
          );
          return;
        }

        // Parse and format birth date
        DateTime birthDate =
            DateFormat("yyyy-MM-dd").parse(_birthDateController.text);
        String formattedBirthDate = DateFormat("yyyy-MM-dd").format(birthDate);

        await NationalIdService().submitNationalId(
          birthDate: formattedBirthDate,
          birthGovernorate: _birthGovernorateController.text,
          gender: _genderController.text,
          nationalId: _nationalIdController.text,
          image: compressedImage,
        );

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('National ID submitted successfully.'),
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to submit national ID: ${e.toString()}'),
          ),
        );
        print('Error during national ID submission: $e');
      } finally {
        setState(() => _isLoading = false);
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill all the fields and upload an image.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorsManager.white,
        automaticallyImplyLeading: false,
        title: Center(
          child: Text(
            'Submit National ID',
            style: GoogleFonts.sora(
              color: ColorsManager.mainGreen,
              fontSize: 20.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _birthDateController,
                decoration: const InputDecoration(labelText: 'Birth Date'),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter your birth date' : null,
                keyboardType: TextInputType.datetime,
              ),
              TextFormField(
                controller: _birthGovernorateController,
                decoration:
                    const InputDecoration(labelText: 'Birth Governorate'),
                validator: (value) => value!.isEmpty
                    ? 'Please enter your birth governorate'
                    : null,
              ),
              TextFormField(
                controller: _genderController,
                decoration: const InputDecoration(labelText: 'Gender'),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter your gender' : null,
              ),
              TextFormField(
                controller: _nationalIdController,
                decoration: const InputDecoration(labelText: 'National ID'),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter your national ID' : null,
              ),
              const SizedBox(height: 16),
              _isLoading // Show loading indicator or button
                  ? const Center(child: CircularProgressIndicator())
                  : TextButton(
                      onPressed: _pickImage,
                      child: const Text(
                        'Upload National ID Image',
                        style: TextStyle(color: ColorsManager.mainGreen),
                      ),
                    ),
              _image == null
                  ? const SizedBox() // No image, show nothing
                  : Image.file(_image!),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _submitNationalId,
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorsManager.mainGreen,
                ),
                child: const Text(
                  'Submit',
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
