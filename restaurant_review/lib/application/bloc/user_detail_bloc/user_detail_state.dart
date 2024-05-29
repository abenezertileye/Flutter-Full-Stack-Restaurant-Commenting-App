import 'package:restaurant_review/domain/entities/user_detail_entity.dart';

abstract class UserState {}

class UserInitial extends UserState {}

class UserDetailLoading extends UserState {}

class UserLoading extends UserState {}

class UserLoaded extends UserState {
  final UserDetail user;

  UserLoaded(this.user);
}

class UserError extends UserState {
  final String message;

  UserError(this.message);
}

class PasswordUpdating extends UserState {}

class PasswordUpdated extends UserState {
  final String message;

  PasswordUpdated(this.message);
}

class DeletingAccount extends UserState {}

class AccountDeleted extends UserState {
  final String message;

  AccountDeleted(this.message);
}
