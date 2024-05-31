import 'package:bloc/bloc.dart';
import 'package:restaurant_review/application/bloc/restaurant_page_bloc/restaurant_page_bloc.dart';
import 'package:restaurant_review/application/bloc/restaurant_page_bloc/restaurant_page_state.dart';
import 'package:restaurant_review/application/bloc/restaurant_page_bloc/restaurant_page_event.dart';
import 'package:restaurant_review/domain/usecase/restaurant_page_usecase.dart';

class RestaurantPageBloc
    extends Bloc<RestaurantPageEvent, RestaurantPageState> {
  final RestaurantPageUseCase restaurantPageUseCase;
  final String restaurantId;

  RestaurantPageBloc(
      {required this.restaurantPageUseCase, required this.restaurantId})
      : super(RestaurantPageInitial()) {
    on<FetchRestaurantDetails>(_onFetchRestaurantDetails);
    on<CreateCommentButtonPressed>(_onCreateCommentButtonPressed);
    on<DeleteCommentButtonPressed>(_onDeleteCommentButtonPressed);
    on<UpdateCommentButtonPressed>(_onUpdateCommentButtonPressed);
  }

  void _onFetchRestaurantDetails(
      FetchRestaurantDetails event, Emitter<RestaurantPageState> emit) async {
    emit(RestaurantPageLoading());
    try {
      final restaurant = await restaurantPageUseCase.fetch(restaurantId);
      emit(RestaurantPageLoaded(restaurant));
    } catch (error) {
      emit(RestaurantPageError('Failed to fetch restaurant details: $error'));
    }
  }

  void _onCreateCommentButtonPressed(CreateCommentButtonPressed event,
      Emitter<RestaurantPageState> emit) async {
    emit(CreateCommentLoading());
    print('create comment loading');
    print('create Comment loading in bloc, opinion: ${event.opinion}');
    print('create Comment loading in bloc, restId:  ${event.restId}');
    try {
      final confirmation = await restaurantPageUseCase.createComment(
          opinion: event.opinion, restId: event.restId);
      emit(CreateCommentLoaded(confirmation));
    } catch (error) {
      emit(CreateCommentError('Failed create comment: $error'));
    }
  }

  void _onUpdateCommentButtonPressed(UpdateCommentButtonPressed event,
      Emitter<RestaurantPageState> emit) async {
    emit(UpdateCommentLoading());
    print(
        'UpdateCommentLoading in bloc, opinion: ${event.opinion}, id: ${event.commentId}');
    try {
      final updateConfirmation = await restaurantPageUseCase.updateComment(
          opinion: event.opinion, commentId: event.commentId);
      emit(UpdateCommentLoaded(updateConfirmation));
    } catch (error) {
      emit(UpdateCommentError('Failed to fetch restaurant details: $error'));
    }
  }

  void _onDeleteCommentButtonPressed(DeleteCommentButtonPressed event,
      Emitter<RestaurantPageState> emit) async {
    emit(DeleteCommentLoading());
    print('DeleteCommentLoading in bloc, Delete: ${event.commentId}');
    try {
      final confirmation =
          await restaurantPageUseCase.deleteComment(commentId: event.commentId);
      emit(DeleteCommentLoaded(confirmation));
      print('comment delted');
    } catch (error) {
      emit(DeleteCommentError('Failed to delete comment: $error'));
    }
  }
}
