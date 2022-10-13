import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(const ThemeState(switchValue: false));

  void changeTheme(bool value) {
    emit(state.copyWith(switchValue: value));
  }
}
