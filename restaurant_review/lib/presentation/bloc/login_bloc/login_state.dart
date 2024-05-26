import 'package:restaurant_review/models/user_types.dart';
import 'package:restaurant_review/domain/entities/user.dart';

abstract class LogInState {}

class LogInInitial extends LogInState {}

class LogInLoading extends LogInState {}

class LogInSuccess extends LogInState {
  final Map<String, dynamic> user;

  LogInSuccess(this.user);
}

class LogInFailure extends LogInState {
  final String error;

  LogInFailure(this.error);
}
