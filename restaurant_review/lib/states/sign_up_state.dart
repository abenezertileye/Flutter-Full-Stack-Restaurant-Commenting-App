import 'package:restaurant_review/models/user_types.dart';

abstract class SignUpState {}

class SignUpInitial extends SignUpState {}

class SignUpLoading extends SignUpState {}

class SignUpSuccess extends SignUpState {}

class SignUpFailure extends SignUpState {
  final String error;

  SignUpFailure(this.error);
}

class UserTypeUpdated extends SignUpState {
  final UserType userType;

  UserTypeUpdated({required this.userType});
}
