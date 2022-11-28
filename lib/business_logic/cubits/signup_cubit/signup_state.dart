import 'package:equatable/equatable.dart';

enum SignupStatus { signOut, loading, success, error }

class SignupState extends Equatable {
  final String email;
  final String password;
  final String name;
  final String id;
  final SignupStatus status;
  const SignupState({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.status,
  });

  factory SignupState.initial() {
    return const SignupState(
      email: '',
      password: '',
      status: SignupStatus.signOut,
      name: '',
      id: '',
    );
  }

  SignupState copyWith({
    String? name,
    String? email,
    String? password,
    String? id,
    SignupStatus? status,
  }) {
    return SignupState(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [email, password, status, name, id];
}
