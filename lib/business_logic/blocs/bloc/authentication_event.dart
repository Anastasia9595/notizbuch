part of 'authentication_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

// When the user pressed the sign in button this event is called and the  [AuthRepository] is called to sign in the user
class SignIn extends AuthEvent {
  final String email;
  final String password;

  const SignIn({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

// When the user pressed the sign up button this event is called and the  [AuthRepository] is called to sign up the user
class SignUp extends AuthEvent {
  final String email;
  final String password;

  const SignUp({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}
