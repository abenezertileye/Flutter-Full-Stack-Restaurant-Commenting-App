import 'package:bloc/bloc.dart';
import 'package:restaurant_review/presentation/bloc/sign_up_bloc/sign_up_events.dart';
import 'package:restaurant_review/presentation/bloc/sign_up_bloc/sign_up_state.dart';
import 'package:restaurant_review/models/user_types.dart';
import 'package:restaurant_review/domain/usecase/signup_usecase.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final SignUpUseCase signUpUseCase;

  SignUpBloc({required this.signUpUseCase}) : super(SignUpInitial()) {
    on<SignUpButtonPressed>(_onSignUpButtonPressed);
    on<UserTypeSelected>(_onUserTypeSelected);
  }

  void _onSignUpButtonPressed(
      SignUpButtonPressed event, Emitter<SignUpState> emit) async {
    emit(SignUpLoading());
    // print({
    //   'username': event.username,
    //   'email': event.email,
    //   'password': event.password,
    //   'userType': event.userType,
    // });
    print('SignUpLoading state emitted');
    try {
      final userData = await signUpUseCase.execute(
        username: event.username,
        email: event.email,
        password: event.password,
        userType: event.userType,
      );
      // print('User data received in bloc: $userData');
      emit(SignUpSuccess(userData));
      print('state: $state');
    } catch (error) {
      emit(SignUpFailure('Failed to sign up: $error'));
      print(error);
    }
  }

  void _onUserTypeSelected(UserTypeSelected event, Emitter<SignUpState> emit) {
    emit(UserTypeUpdated(userType: event.userType));
  }
}
