abstract class UserEvent {}

class FetchUserRequested extends UserEvent {}

class FetchUserDetail extends UserEvent {}

class UpdateUsername extends UserEvent {
  final String username;

  UpdateUsername({required this.username});
}

class UpdatePassword extends UserEvent {
  final String oldPassword;
  final String newPassword;

  UpdatePassword({required this.oldPassword, required this.newPassword});
}

class DeleteAccount extends UserEvent {}
