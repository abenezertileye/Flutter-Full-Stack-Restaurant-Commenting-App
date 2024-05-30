import 'package:equatable/equatable.dart';
import 'package:restaurant_review/domain/entities/restaurant_entity.dart';
import 'package:restaurant_review/domain/entities/user_detail_entity.dart';

abstract class AdminState extends Equatable {
  @override
  List<Object> get props => [];
}

class AdminInitial extends AdminState {}

class AdminLoading extends AdminState {}

class AdminLoaded extends AdminState {
  final List<UserDetail> owners;
  final List<UserDetail> customers;

  AdminLoaded({required this.owners, required this.customers});

  @override
  List<Object> get props => [owners, customers];
}

class AdminError extends AdminState {
  final String message;

  AdminError({required this.message});
}
