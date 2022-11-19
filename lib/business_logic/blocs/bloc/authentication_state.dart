part of 'authentication_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

// When the user pressed the sign in button or the sign up button the state is changed to loading
class Loading extends AuthState {
  @override
  List<Object> get props => [];
}

// When the user is authenticated the state is changed to authenticated
class Authenticated extends AuthState {
  final User user;

  const Authenticated(this.user);

  @override
  List<Object> get props => [user];
}

// When the user is not authenticated the state is changed to unauthenticated
class Unauthenticated extends AuthState {
  @override
  List<Object> get props => [];
}

// If any error occurs the state is changed to error
class Error extends AuthState {
  final String message;

  const Error(this.message);

  @override
  List<Object> get props => [message];
}
