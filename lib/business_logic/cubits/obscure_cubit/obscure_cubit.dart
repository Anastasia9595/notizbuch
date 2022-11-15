import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'obscure_state.dart';

class ObscureCubit extends Cubit<ObscureState> {
  ObscureCubit() : super(ObscureState(obscureText: false));

  void toggleObscure() {
    emit(state.copyWith(obscureText: !state.obscureText));
  }
}
