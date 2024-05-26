import 'package:restaurant_review/presentation/screens/sign_up_page.dart';
import 'package:restaurant_review/models/user_types.dart';

abstract class SignUpEvent {}

class SignUpButtonPressed extends SignUpEvent {
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

class UserTypeSelected extends SignUpEvent {
  final UserType userType;

  UserTypeSelected({required this.userType});
}
