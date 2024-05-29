import '../../../domain/entities/restaurant_entity.dart';

abstract class RestaurantPageState {}

class RestaurantPageInitial extends RestaurantPageState {}

class RestaurantPageLoading extends RestaurantPageState {}

class RestaurantPageLoaded extends RestaurantPageState {
  final Restaurant restaurant;

  RestaurantPageLoaded(this.restaurant);
}

class RestaurantPageError extends RestaurantPageState {
  final String message;

  RestaurantPageError(this.message);
}

class CreateCommentInitial extends RestaurantPageState {}

class CreateCommentLoading extends RestaurantPageState {}

class CreateCommentLoaded extends RestaurantPageState {
  final String confirmation;

  CreateCommentLoaded(this.confirmation);
}

class CreateCommentError extends RestaurantPageState {
  final String message;

  CreateCommentError(this.message);
}

class UpdateCommentInitial extends RestaurantPageState {}

class UpdateCommentLoading extends RestaurantPageState {}

class UpdateCommentLoaded extends RestaurantPageState {
  final String confirmation;

  UpdateCommentLoaded(this.confirmation);
}

class UpdateCommentError extends RestaurantPageState {
  final String message;

  UpdateCommentError(this.message);
}

class DeleteCommentInitial extends RestaurantPageState {}

class DeleteCommentLoading extends RestaurantPageState {}

class DeleteCommentLoaded extends RestaurantPageState {
  final String confirmation;

  DeleteCommentLoaded(this.confirmation);
}

class DeleteCommentError extends RestaurantPageState {
  final String error;

  DeleteCommentError(this.error);
}
