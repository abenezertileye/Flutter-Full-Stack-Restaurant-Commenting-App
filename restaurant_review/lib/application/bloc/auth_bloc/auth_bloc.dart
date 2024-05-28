import 'package:bloc/bloc.dart';
import 'package:restaurant_review/application/bloc/auth_bloc/auth_events.dart';
import 'package:restaurant_review/application/bloc/auth_bloc/auth_state.dart';
import 'package:restaurant_review/models/user_types.dart';
import 'package:restaurant_review/domain/usecase/auth_usecase.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthUseCase authUseCase;

  AuthBloc({required this.authUseCase}) : super(AuthInitial()) {
    on<SignUpButtonPressed>(_onSignUpButtonPressed);
    on<LogInButtonPressed>(_onLogInButtonPressed);
    on<UserTypeSelected>(_onUserTypeSelected);
  }

  void _onSignUpButtonPressed(
      SignUpButtonPressed event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    // print({
    //   'username': event.username,
    //   'email': event.email,
    //   'password': event.password,
    //   'userType': event.userType,
    // });
    print('SignUpLoading state emitted');
    try {
      final userData = await authUseCase.signup(
        username: event.username,
        email: event.email,
        password: event.password,
        userType: event.userType,
      );
      print('userData in auth bloc : $userData');
      // print('User data received in bloc: $userData');
      emit(AuthSuccess(userData));
      print('state: $state');
    } catch (error) {
      emit(AuthFailure('Failed to sign up: $error'));
      print(error);
    }
  }

  void _onLogInButtonPressed(
      LogInButtonPressed event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    // print({
    //   'username': event.username,
    //   'email': event.email,
    //   'password': event.password,
    //   'userType': event.userType,
    // });
    print('LogInLoading state emitted');
    try {
      final userData = await authUseCase.login(
        username: event.username,
        password: event.password,
      );
      print('userData in auth bloc : $userData');
      // print('User data received in bloc: $userData');
      emit(AuthSuccess(userData));
      print('state: $state');
    } catch (error) {
      emit(AuthFailure('Failed to sign up: $error'));
      print(error);
    }
  }

  void _onUserTypeSelected(UserTypeSelected event, Emitter<AuthState> emit) {
    emit(UserTypeUpdated(userType: event.userType));
  }
}
