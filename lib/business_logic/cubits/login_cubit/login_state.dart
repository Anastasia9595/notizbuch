import 'package:equatable/equatable.dart';

import '../../../data/model/user.dart';

enum LoginStatus { update, submitting, sucess, error, signedOut, loading }

class LoginState extends Equatable {
  final String email;
  final String password;
  final String name;
  final User user;
  final LoginStatus status;
  const LoginState({
    required this.name,
    required this.user,
    required this.email,
    required this.password,
    required this.status,
  });

  factory LoginState.initial() {
    return const LoginState(
      email: '',
      password: '',
      user: User.empty,
      status: LoginStatus.update,
      name: '',
    );
  }

  @override
  List<Object> get props => [email, password, status, user, name];

  LoginState copyWith({
    String? name,
    String? email,
    String? password,
    LoginStatus? status,
    User? user,
  }) {
    return LoginState(
      name: name ?? this.name,
      user: user ?? this.user,
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
    );
  }
}
