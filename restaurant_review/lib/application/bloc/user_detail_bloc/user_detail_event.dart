abstract class UserEvent {}

class FetchUserRequested extends UserEvent {}

class FetchUserDetail extends UserEvent {}

class UpdatePassword extends UserEvent {
  final String oldPassword;
  final String newPassword;

  UpdatePassword({required this.oldPassword, required this.newPassword});
}

class DeleteAccount extends UserEvent {}
