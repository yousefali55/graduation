import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
part 'register_with_upload_image_state.dart';

class RegisterWithUploadImageCubit extends Cubit<RegisterWithUploadImageState> {
  RegisterWithUploadImageCubit() : super(RegisterWithUploadImageInitial());
    String? url; 
    File? file;
    TextEditingController userNameController = TextEditingController();
    uploadImage() async{
      try{
        emit(UploadImageLoading());
            final ImagePicker imagePicker = ImagePicker();
    final XFile? imagegallery =
        await imagePicker.pickImage(source: ImageSource.gallery);
    if(imagegallery !=null){
      file = File(imagegallery.path);
      var imageName = basename(imagegallery.path);
      var refStorage = FirebaseStorage.instance.ref('Images/$imageName');
      await refStorage.putFile(file!);
      url = await refStorage.getDownloadURL();
      }
      emit(UploadImageSuccess());
      }catch(errorMessage){
        emit(UploadImageFailure(errorMessage: errorMessage.toString()));
      }
    }
    registerAccount() async{
      try{
        emit(RegisterWithUploadImageLoading());
        RegisterWithUploadImageLoading();
        CollectionReference users = FirebaseFirestore.instance.collection('users');
        await users.add({
          'id': FirebaseAuth.instance.currentUser!.uid,
          'username': userNameController.text,
          'url': url,
        });
        emit(RegisterWithUploadImageSuccess());
      }catch(errorMessage){
        emit(RegisterWithUploadImageFailure(errorMessage: errorMessage.toString()));
      }
    }
    

}
