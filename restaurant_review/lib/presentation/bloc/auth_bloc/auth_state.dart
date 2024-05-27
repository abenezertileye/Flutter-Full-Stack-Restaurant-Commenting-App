import 'package:restaurant_review/models/user_types.dart';
import 'package:restaurant_review/domain/entities/user.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final Map<String, dynamic> user;

  AuthSuccess(this.user);
}

class AuthFailure extends AuthState {
  final String error;

  AuthFailure(this.error);
}

class UserTypeUpdated extends AuthState {
  final UserType userType;

  UserTypeUpdated({required this.userType});
}
