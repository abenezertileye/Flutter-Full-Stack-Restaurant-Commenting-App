import 'package:equatable/equatable.dart';
import 'package:restaurant_review/domain/entities/create_restaurant_entity.dart';
import 'package:restaurant_review/domain/entities/update_restaurant_entity.dart';

abstract class RestaurantCrudEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class CreateRestaurantRequested extends RestaurantCrudEvent {
  final CreateRestaurantDTO restaurant;

  CreateRestaurantRequested(this.restaurant);

    @override
  List<Object> get props => [restaurant];
}

class UpdateRestaurantRequested extends RestaurantCrudEvent {
  final UpdateRestaurantDTO restaurant;

  UpdateRestaurantRequested(this.restaurant);

    @override
  List<Object> get props => [restaurant];
}

class DeleteRestaurantRequested extends RestaurantCrudEvent {}