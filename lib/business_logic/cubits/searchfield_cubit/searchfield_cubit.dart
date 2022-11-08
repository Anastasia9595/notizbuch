import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'searchfield_state.dart';

class SearchfieldCubit extends Cubit<SearchfieldState> {
  SearchfieldCubit()
      : super(
          SearchfieldState(
            controller: TextEditingController(),
            focusNode: FocusNode(),
            folded: true,
          ),
        );

  void setFolded(bool value) {
    emit(state.copyWith(folded: value));
  }
}
