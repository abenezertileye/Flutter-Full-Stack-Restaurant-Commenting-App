import 'package:equatable/equatable.dart';

abstract class AdminEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchUsers extends AdminEvent {}

class ToggleBanCustomer extends AdminEvent {
  final String username;
  final bool isBanned;

  ToggleBanCustomer({required this.username, required this.isBanned});

  @override
  List<Object> get props => [username, isBanned];
}

class ToggleUnBanCustomer extends AdminEvent {
  final int index;
  final bool isBanned;

  ToggleUnBanCustomer({required this.index, required this.isBanned});

  @override
  List<Object> get props => [index, isBanned];
}

class ToggleBanOwner extends AdminEvent {
  final String username;
  final bool isBanned;

  ToggleBanOwner({required this.username, required this.isBanned});

  @override
  List<Object> get props => [username, isBanned];
}

class ToggleUnBanOwner extends AdminEvent {
  final String username;
  final bool isBanned;

  ToggleUnBanOwner({required this.username, required this.isBanned});

  @override
  List<Object> get props => [username, isBanned];
}
