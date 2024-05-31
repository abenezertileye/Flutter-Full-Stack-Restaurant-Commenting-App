import 'package:bloc/bloc.dart';
import 'package:restaurant_review/application/bloc/restaurant_crud_bloc/restaurant_crud_event.dart';
import 'package:restaurant_review/application/bloc/restaurant_crud_bloc/restaurant_crud_state.dart';
import 'package:restaurant_review/domain/usecase/restaurant_crud_usecase.dart';
import 'package:restaurant_review/infrastructure/repository/restaurant_crud_repository.dart';


class RestaurantCrudBloc extends Bloc<RestaurantCrudEvent, RestaurantCrudState> {
  final RestaurantCrudUsecase _restaurantCrudUsecase;

  RestaurantCrudBloc(this._restaurantCrudUsecase) : super(RestaurantCrudInitial()) {
    on<CreateRestaurantRequested>(_onCreateRestaurantRequested);
    on<UpdateRestaurantRequested>(_onUpdateRestaurantRequested);
    on<DeleteRestaurantRequested>(_onDeleteRestaurantRequested);
  }

  void _onCreateRestaurantRequested(CreateRestaurantRequested event, Emitter<RestaurantCrudState> emit) async {
    emit(RestaurantCreationLoading());
    final result = await _restaurantCrudUsecase.createRestaurant(event.restaurant);
    result.fold(
      (failure) => emit(RestaurantCrudError(failure.message)),
      (createdRestaurant) => emit(RestaurantCreated(createdRestaurant)),
    );
  }

  void _onUpdateRestaurantRequested(UpdateRestaurantRequested event, Emitter<RestaurantCrudState> emit) async {
    emit(RestaurantUpdateLoading());
    final result = await _restaurantCrudUsecase.updateRestaurant(event.restaurant);
    result.fold(
      (failure) => emit(RestaurantCrudError(failure.message)),
      (updatedRestaurant) => emit(RestaurantUpdated(updatedRestaurant)),
    );
  }

  void _onDeleteRestaurantRequested(DeleteRestaurantRequested event, Emitter<RestaurantCrudState> emit) async {
    emit(RestaurantDeleteLoading());
    final result = await _restaurantCrudUsecase.deleteRestaurant();
    result.fold(
      (failure) => emit(RestaurantCrudError(failure.message)),
      (_) => emit(RestaurantDeleted()),
    );
  }
}
