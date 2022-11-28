import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repository/auth_repository.dart';
import 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  final AuthRepository _authRepository;
  SignupCubit(this._authRepository) : super(SignupState.initial());

  // sign up with email and password
  signUpWithCredentials(String email, String password, String name, BuildContext context) async {
    emit(state.copyWith(status: SignupStatus.loading));
    try {
      UserCredential? user = await _authRepository.signUp(email: email, password: password);

      // await _authRepository.addUserToFirestore(name, email, state.id);
      emit(state.copyWith(id: user!.user!.uid, status: SignupStatus.success));
      log('id: ${state.id}');
      try {
        await _authRepository.addUserToFirestore(name, email, state.id);
        // final docUser = FirebaseFirestore.instance.collection('users').doc(state.id);
        // await docUser.set({
        //   'name': name.trim(),
        //   'email': email.trim(),
        // });
        emit(state.copyWith(status: SignupStatus.success, id: user.user?.uid));
      } catch (e) {
        log(e.toString());
      }
      // log('id: ${state.id}');
    } catch (e) {
      log(e.toString());
      emit(state.copyWith(status: SignupStatus.error));
    }
  }

  // sign out the current user
  signOut() async {
    try {
      await _authRepository.signOut();
      //emit(state.copyWith(status: SignupStatus.signOut));
    } catch (e) {
      log(e.toString());
      emit(state.copyWith(status: SignupStatus.error));
    }
  }

  // add user to database
  addUserToDatabase(
    String name,
    String email,
    BuildContext context,
  ) async {
    showDialog(
        context: context,
        builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ));
    try {
      final docUser = FirebaseFirestore.instance.collection('users').doc(state.id);
      await docUser.set({
        'name': name.trim(),
        'email': email.trim(),
      });
      emit(state.copyWith(status: SignupStatus.success));
    } catch (e) {
      log(e.toString());
    }
  }
}
