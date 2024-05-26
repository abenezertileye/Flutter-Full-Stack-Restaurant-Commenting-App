import 'package:restaurant_review/models/user_types.dart';
import 'package:restaurant_review/domain/entities/user.dart';

abstract class SignUpState {}

class SignUpInitial extends SignUpState {}

class SignUpLoading extends SignUpState {}

class SignUpSuccess extends SignUpState {
  final Map<String, dynamic> user;

  SignUpSuccess(this.user);
}

class SignUpFailure extends SignUpState {
  final String error;

  SignUpFailure(this.error);
}

class UserTypeUpdated extends SignUpState {
  final UserType userType;

  UserTypeUpdated({required this.userType});
}
