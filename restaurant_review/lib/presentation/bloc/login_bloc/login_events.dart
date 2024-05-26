import 'package:restaurant_review/presentation/screens/login_in_page.dart';
import 'package:restaurant_review/models/user_types.dart';

abstract class LoginEvent {}

class LogInButtonPressed extends LoginEvent {
  final String email;
  final String password;

  LogInButtonPressed({
    required this.email,
    required this.password,
  });
}

class UserTypeSelected extends LoginEvent {
  final UserType userType;

  UserTypeSelected({required this.userType});
}
