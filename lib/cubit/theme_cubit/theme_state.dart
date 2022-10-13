part of 'theme_cubit.dart';

class ThemeState extends Equatable {
  final bool switchValue;

  const ThemeState({required this.switchValue});

  ThemeState copyWith({bool? switchValue}) {
    return ThemeState(switchValue: switchValue ?? this.switchValue);
  }

  @override
  List<Object?> get props => [switchValue];
}
