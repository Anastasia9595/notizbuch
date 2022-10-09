import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'font_state.dart';

class FontCubit extends Cubit<FontState> {
  FontCubit() : super(FontState(boldFont: false, italicFont: false, underlineFont: false, checkBox: false));

  // set Checkbox to the value of the checkbox
  void setCheckBox(bool value) {
    emit(state.copyWith(checkBox: value));
  }

  void setBoldFont(bool vlaue) {
    emit(state.copyWith(boldFont: vlaue));
  }

  void setItalicFont(bool vlaue) {
    emit(state.copyWith(italicFont: vlaue));
  }

  void setUnderlineFont(bool vlaue) {
    emit(state.copyWith(underlineFont: vlaue));
  }
}
