import 'package:restaurant_review/domain/entities/user_detail_entity.dart';

abstract class UserState {}

//state to load user state
class UserInitial extends UserState {}

class UserDetailLoading extends UserState {}

class UserLoading extends UserState {}

//events indicating user state is loaded
class UserLoaded extends UserState {
  final UserDetail user;

  UserLoaded(this.user);
}

//events for errors durning loading
class UserError extends UserState {
  final String message;

  UserError(this.message);
}
//events for password update

class PasswordUpdating extends UserState {}

class PasswordUpdated extends UserState {
  final String message;

  PasswordUpdated(this.message);
}

//events to delete account
class DeletingAccount extends UserState {}

class AccountDeleted extends UserState {
  final String message;

  AccountDeleted(this.message);
}
