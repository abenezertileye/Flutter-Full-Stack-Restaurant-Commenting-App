import 'package:bloc/bloc.dart';
import 'package:restaurant_review/presentation/bloc/restaurant_page_bloc/restaurant_page_bloc.dart';
import 'package:restaurant_review/presentation/bloc/restaurant_page_bloc/restaurant_page_state.dart';
import 'package:restaurant_review/presentation/bloc/restaurant_page_bloc/restaurant_page_event.dart';
import 'package:restaurant_review/domain/usecase/restaurant_page_usecase.dart';

class RestaurantPageBloc
    extends Bloc<RestaurantPageEvent, RestaurantPageState> {
  final RestaurantPageUseCase restaurantPageUseCase;
  final String restaurantId;

  RestaurantPageBloc(
      {required this.restaurantPageUseCase, required this.restaurantId})
      : super(RestaurantPageInitial()) {
    on<FetchRestaurantDetails>(_onFetchRestaurantDetails);
  }

  void _onFetchRestaurantDetails(
      FetchRestaurantDetails event, Emitter<RestaurantPageState> emit) async {
    emit(RestaurantPageLoading());
    try {
      final restaurant = await restaurantPageUseCase.execute(restaurantId);
      emit(RestaurantPageLoaded(restaurant));
    } catch (error) {
      emit(RestaurantPageError('Failed to fetch restaurant details: $error'));
    }
  }
}
