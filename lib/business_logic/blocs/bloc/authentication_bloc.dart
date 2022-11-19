import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/model/user.dart';
import '../../repository/auth_repository.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  AuthBloc({required this.authRepository}) : super(Unauthenticated()) {
    on<SignIn>((event, emit) async {
      emit(Loading());
      try {
        await authRepository.signIn(email: event.email, password: event.password);
        final user = await authRepository.getUser();
        emit(Authenticated(user as User));
      } on Exception catch (e) {
        emit(Error(e.toString()));
        emit(Unauthenticated());
      }
    });

    on<SignUp>((event, emit) async {
      emit(Loading());
      try {
        await authRepository.signUp(email: event.email, password: event.password);
        final user = await authRepository.getUser();
        emit(Authenticated(user as User));
      } on Exception catch (e) {
        emit(Error(e.toString()));
        emit(Unauthenticated());
      }
    });
  }
}
