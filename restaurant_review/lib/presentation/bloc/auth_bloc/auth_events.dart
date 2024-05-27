import 'package:restaurant_review/presentation/screens/sign_up_page.dart';
import 'package:restaurant_review/models/user_types.dart';

abstract class AuthEvent {}

class SignUpButtonPressed extends AuthEvent {
  final String username;
  final String email;
  final String password;
  final UserType userType;

  SignUpButtonPressed({
    required this.username,
    required this.email,
    required this.password,
    required this.userType,
  });
}

class LogInButtonPressed extends AuthEvent {
  final String username;
  final String password;

  LogInButtonPressed({
    required this.username,
    required this.password,
  });
}

class UserTypeSelected extends AuthEvent {
  final UserType userType;

  UserTypeSelected({required this.userType});
}
