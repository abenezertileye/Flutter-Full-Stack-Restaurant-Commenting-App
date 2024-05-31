import 'package:restaurant_review/domain/entities/user_detail_entity.dart';

abstract class UserState {}

//state to load user state
class UserInitial extends UserState {}

class UserDetailLoading extends UserState {}

class UserLoading extends UserState {}

//state indicating user state is loaded
class UserLoaded extends UserState {
  final UserDetail user;

  UserLoaded(this.user);
}

//state for errors durning loading
class UserError extends UserState {
  final String message;

  UserError(this.message);
}
//state for password update

class UsernameUpdating extends UserState {}

class UsernameUpdated extends UserState {
  final String message;

  UsernameUpdated(this.message);
}

class PasswordUpdating extends UserState {}

class PasswordUpdated extends UserState {
  final String message;

  PasswordUpdated(this.message);
}

//state to delete account
class DeletingAccount extends UserState {}

class AccountDeleted extends UserState {
  final String message;

  AccountDeleted(this.message);
}
