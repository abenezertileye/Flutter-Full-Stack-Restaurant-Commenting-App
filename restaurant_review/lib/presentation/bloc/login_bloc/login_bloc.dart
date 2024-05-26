import 'package:bloc/bloc.dart';
import 'package:restaurant_review/presentation/bloc/login_bloc/login_events.dart';
import 'package:restaurant_review/presentation/bloc/login_bloc/login_state.dart';
import 'package:restaurant_review/models/user_types.dart';
import 'package:restaurant_review/domain/usecase/login_usecase.dart';

class LoginBloc extends Bloc<LoginEvent, LogInState> {
  final LogInUseCase logInUseCase;

  LoginBloc({required this.logInUseCase}) : super(LogInInitial()) {
    on<LogInButtonPressed>(_onLogInButtonPressed);
  }

  void _onLogInButtonPressed(
      LogInButtonPressed event, Emitter<LogInState> emit) async {
    emit(LogInLoading());
    print({
      'username': event.email,
      'password': event.password,
    });
    print('LogInLoading state emitted');
    try {
      final userData = await logInUseCase.execute(
        email: event.email,
        password: event.password,
      );
      print('User data received in bloc: $userData');
      emit(LogInSuccess(userData));
      print('state: $state');
    } catch (error) {
      emit(LogInFailure('Failed to sign up: $error'));
      print(error);
    }
  }
}
