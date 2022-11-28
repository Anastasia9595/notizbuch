import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repository/auth_repository.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepository _authRepository;
  LoginCubit(this._authRepository)
      : super(
          LoginState.initial(),
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
  void getCurrentUserName(int id) async {
    final name = await _authRepository.fetchData('name');
    emit(state.copyWith(name: name ?? ''));
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
      await _authRepository.signIn(email: email, password: password);

      emit(state.copyWith(status: LoginStatus.sucess));
    } catch (e) {
      log(e.toString());
      emit(state.copyWith(status: LoginStatus.error));
    }
  }

  Future<void> signOut() async {
    try {
      await _authRepository.signOut();
      emit(state.copyWith(status: LoginStatus.signedOut));
    } catch (e) {
      log(e.toString());
      emit(state.copyWith(status: LoginStatus.error));
    }
  }
}
