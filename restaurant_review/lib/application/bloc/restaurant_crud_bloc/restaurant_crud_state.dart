import 'package:equatable/equatable.dart';
import 'package:restaurant_review/domain/entities/create_restaurant_entity.dart';
import 'package:restaurant_review/domain/entities/update_restaurant_entity.dart';

abstract class RestaurantCrudState extends Equatable {
  @override
  List<Object?> get props => [];
}
class RestaurantCrudInitial extends RestaurantCrudState {}

class RestaurantCreationLoading extends RestaurantCrudState {}

class RestaurantCreated extends RestaurantCrudState {
  final CreateRestaurantDTO restaurant;

  RestaurantCreated(this.restaurant);

  @override
  List<Object?> get props => [restaurant];
}

class RestaurantUpdateLoading extends RestaurantCrudState {}

class RestaurantUpdated extends RestaurantCrudState {
  final UpdateRestaurantDTO restaurant;

  RestaurantUpdated(this.restaurant);

  @override
  List<Object?> get props => [restaurant];
}

class RestaurantDeleteLoading extends RestaurantCrudState {}

class RestaurantDeleted extends RestaurantCrudState {}

class RestaurantCrudError extends RestaurantCrudState {
  final String message;

  RestaurantCrudError(this.message);

  @override
  List<Object?> get props => [message];
}
