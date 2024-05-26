import 'package:bloc/bloc.dart';
import 'package:restaurant_review/presentation/bloc/home_page_bloc/restaurants_event.dart';
import 'package:restaurant_review/presentation/bloc/home_page_bloc/restaurants_state.dart';
import 'package:restaurant_review/domain/usecase/restaurants_usecase.dart';

class RestaurantBloc extends Bloc<RestaurantEvent, RestaurantState> {
  final RestaurantsUseCase restaurantsUseCase;

  RestaurantBloc({required this.restaurantsUseCase})
      : super(RestaurantInitial()) {
    on<FetchRestaurants>(_onFetchRestaurants);
    print('rest bloc called');
  }

  void _onFetchRestaurants(
      FetchRestaurants event, Emitter<RestaurantState> emit) async {
    emit(RestaurantLoading());
    print('loading restaurants');
    try {
      final restaurants = await restaurantsUseCase.execute();
      emit(RestaurantLoaded(restaurants));
      print(restaurants);
    } catch (e) {
      emit(RestaurantError("Failed to fetch restaurants"));
      print(e);
    }
  }
}
