import 'package:bloc/bloc.dart';
import 'package:restaurant_review/events/sign_up_events.dart';
import 'package:restaurant_review/states/sign_up_state.dart';
import 'package:restaurant_review/models/user_types.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(SignUpInitial()) {
    on<SignUpButtonPressed>(_onSignUpButtonPressed);
    on<UserTypeSelected>(_onUserTypeSelected);
  }

  void data() {
    // Add print statements here to check if data has passed through this method
    print('Data function called');
  }

  void _onSignUpButtonPressed(
      SignUpButtonPressed event, Emitter<SignUpState> emit) async {
    emit(SignUpLoading());
    // print('Sign Up button pressed');
    // print('Username: ${event.username}');
    // print('Email: ${event.email}');
    // print('Password: ${event.password}');
    // print('User type: ${event.userType}');
    const String url = 'http://localhost:3000';
    try {
      final response = await http.post(
        Uri.parse('$url/auth/signup'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'username': event.username,
          'email': event.email,
          'password': event.password,
          'roles': event.userType == UserType.owner ? 'owner' : 'customer',
        }),
      );

      if (response.statusCode == 201) {
        emit(SignUpSuccess());
      } else {
        emit(SignUpFailure('Failed to sign up: ${response.reasonPhrase}'));
      }
    } catch (error) {
      emit(SignUpFailure('Failed to sign up: $error'));
    }
  }

  void _onUserTypeSelected(UserTypeSelected event, Emitter<SignUpState> emit) {
    emit(UserTypeUpdated(userType: event.userType));
    print('User type selected: ${event.userType}');
  }
}
