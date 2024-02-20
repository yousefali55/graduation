import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
part 'sign_up_email_state.dart';
class SignUpEmailCubit extends Cubit<SignUpEmailState> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  SignUpEmailCubit() : super(SignUpEmailInitial());
  signUpEmail() async {
    try {
      emit(SignUpEmailLaoding());
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      emit(SignUpEmailSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(SignUpEmailFailure(
            errorMessage: 'The password provided is too weak.'));
      } else if (e.code == 'email-already-in-use') {
        emit(SignUpEmailFailure(
            errorMessage: 'The account already exists for that email.'));
      }
    } catch (e) {
      emit(SignUpEmailFailure(errorMessage: e.toString()));
    }
  }
}

