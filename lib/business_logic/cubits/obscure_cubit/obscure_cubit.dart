import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'obscure_state.dart';

class ObscureCubit extends Cubit<ObscureState> {
  ObscureCubit() : super(const ObscureState(obscureText: false));

  void toggleObscure() {
    emit(state.copyWith(obscureText: !state.obscureText));
  }
}
