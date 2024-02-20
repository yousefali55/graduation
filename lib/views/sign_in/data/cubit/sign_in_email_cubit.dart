import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'sign_in_email_state.dart';

class SignInEmailCubit extends Cubit<SignInEmailState> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey formKey = GlobalKey();
  SignInEmailCubit() : super(SignInEmailInitial());
  signInEmail() async{
    try {
      emit(SignInEmailLaoding());
  await FirebaseAuth.instance.signInWithEmailAndPassword(
    email: emailController.text,
    password: passwordController.text
  );
  emit(SignInEmailSuccess());
}   catch (e) {
  if (e == 'user-not-found') {
    emit(SignInEmailFailure(errorMessage: 'No user found for that email.'));
  } else if (e == 'wrong-password') {
    emit(SignInEmailFailure(errorMessage: 'Wrong password provided for that user.'));
  }
  else if(e.toString() == ' [firebase_auth/invalid-email] The email address is badly formatted.'){
    emit(SignInEmailFailure(errorMessage: 'Try again with correct email'));
  }
  else{
    emit(SignInEmailFailure(errorMessage: e.toString()));
  }
}
  }
}
