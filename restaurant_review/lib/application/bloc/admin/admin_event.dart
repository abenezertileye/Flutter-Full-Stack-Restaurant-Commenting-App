import 'package:equatable/equatable.dart';

abstract class AdminEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchUsers extends AdminEvent {}

class ToggleBanCustomer extends AdminEvent {
  final int index;
  final bool isBanned;

  ToggleBanCustomer({required this.index, required this.isBanned});

  @override
  List<Object> get props => [index, isBanned];
}

class ToggleBanOwner extends AdminEvent {
  final int index;
  final bool isBanned;

  ToggleBanOwner({required this.index, required this.isBanned});

  @override
  List<Object> get props => [index, isBanned];
}
