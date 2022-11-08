part of 'theme_cubit.dart';

class ThemeState extends Equatable {
  final bool switchValue;

  const ThemeState({required this.switchValue});

  ThemeState copyWith({bool? switchValue}) {
    return ThemeState(switchValue: switchValue ?? this.switchValue);
  }

  @override
  List<Object?> get props => [switchValue];

  //to map
  Map<String, dynamic> toMap() {
    return {
      'switchValue': switchValue,
    };
  }

  //from map
  factory ThemeState.fromMap(Map<String, dynamic> map) {
    return ThemeState(
      switchValue: map['switchValue'] as bool,
    );
  }
}
