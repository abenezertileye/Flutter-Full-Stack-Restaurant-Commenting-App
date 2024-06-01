import 'package:equatable/equatable.dart';

abstract class AdminEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchUsers extends AdminEvent {}

//event to ban customers/users
class ToggleBanCustomer extends AdminEvent {
  final String username;
  final bool isBanned;

  ToggleBanCustomer({required this.username, required this.isBanned});

  @override
  List<Object> get props => [username, isBanned];
}

//event to unban a customer
class ToggleUnBanCustomer extends AdminEvent {
  final int index;
  final bool isBanned;

  ToggleUnBanCustomer({required this.index, required this.isBanned});

  @override
  List<Object> get props => [index, isBanned];
}

//event to ban owners
class ToggleBanOwner extends AdminEvent {
  final String username;
  final bool isBanned;

  ToggleBanOwner({required this.username, required this.isBanned});

  @override
  List<Object> get props => [username, isBanned];
}

//event to unban owners
class ToggleUnBanOwner extends AdminEvent {
  final String username;
  final bool isBanned;

  ToggleUnBanOwner({required this.username, required this.isBanned});

  @override
  List<Object> get props => [username, isBanned];
}
