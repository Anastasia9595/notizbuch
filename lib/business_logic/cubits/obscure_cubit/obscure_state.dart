part of 'obscure_cubit.dart';

class ObscureState extends Equatable {
  final bool obscureText;

  const ObscureState({required this.obscureText});
  @override
  List<Object?> get props => [obscureText];

  //copywith
  ObscureState copyWith({
    bool? obscureText,
  }) {
    return ObscureState(
      obscureText: obscureText ?? this.obscureText,
    );
  }
}
