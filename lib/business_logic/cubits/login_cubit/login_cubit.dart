import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/model/user.dart' as user;

import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit()
      : super(
          const LoginState(
              email: '',
              password: '',
              status: LoginStatus.update,
              user: user.User(email: '', name: '', id: ''),
              name: ''),
        );

  void emailChanged(String value, User user) {
    try {
      user.updateEmail(value);

      emit(state.copyWith(email: value, status: LoginStatus.update));
    } catch (e) {
      emit(state.copyWith(status: LoginStatus.error));
    }
  }

  // Get the current user from firebase
  void getCurrentUser(int id) async {
    final currentUser = FirebaseFirestore.instance.collection('users').where('id', isEqualTo: id).snapshots();

    // emit(state.copyWith(user: cu, status: LoginStatus.update));
  }

  // set currentUser
  void setCurrentUserName(String name) {
    emit(state.copyWith(name: name));
  }

  void passwordChanged(String value, User user) {
    try {
      user.updatePassword(value);
      emit(state.copyWith(password: value, status: LoginStatus.update));
    } catch (e) {
      emit(state.copyWith(status: LoginStatus.error));
    }

    emit(state.copyWith(password: value, status: LoginStatus.update));
  }

  Future<void> logInWithCredentials(String email, String password) async {
    emit(state.copyWith(status: LoginStatus.loading));
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      emit(state.copyWith(status: LoginStatus.sucess));
    } catch (e) {
      log(e.toString());
      emit(state.copyWith(status: LoginStatus.error));
    }
  }

  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      emit(state.copyWith(status: LoginStatus.signedOut));
    } catch (e) {
      log(e.toString());
      emit(state.copyWith(status: LoginStatus.error));
    }
  }
}
