import 'package:bloc/bloc.dart';
import 'package:restaurant_review/domain/usecase/user_detail_usecase.dart';
import 'package:restaurant_review/application/bloc/user_detail_bloc/user_detail_state.dart';
import 'package:restaurant_review/application/bloc/user_detail_bloc/user_detail_event.dart';
import 'package:restaurant_review/domain/entities/user_entity.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserUseCase userUseCase;
  final String userId;
  UserBloc({required this.userUseCase, required this.userId})
      : super(UserInitial()) {
    on<FetchUserRequested>(_onFetchUserRequested);
    on<UpdatePassword>(_onUpdatePassword);
    on<DeleteAccount>(_onDeleteAccount);
  }

  void _onFetchUserRequested(
    FetchUserRequested event,
    Emitter<UserState> emit,
  ) async {
    emit(UserLoading());
    try {
      final user = await userUseCase.fetchUserData(userId);
      emit(UserLoaded(user));
      print('user in user bloc: $user');
    } catch (e) {
      emit(UserError('Failed to fetch user data: $e'));
    }
  }

  void _onUpdatePassword(
    UpdatePassword event,
    Emitter<UserState> emit,
  ) async {
    emit(PasswordUpdating());
    print(
        'inside bloc oldPassword: ${event.oldPassword}, newPassword: ${event.newPassword}');

    try {
      final message = await userUseCase.updatePassword(
          userId: userId,
          oldPassword: event.oldPassword,
          newPassword: event.newPassword);
      emit(PasswordUpdated(message));
      print('user in user bloc: $message');
    } catch (e) {
      emit(UserError('Failed to fetch user data: $e'));
    }
  }

  void _onDeleteAccount(
    DeleteAccount event,
    Emitter<UserState> emit,
  ) async {
    emit(DeletingAccount());
    try {
      final message = await userUseCase.deleteAccount(userId);
      emit(AccountDeleted(message));
      print('user in user bloc: $message');
    } catch (e) {
      emit(UserError('Failed to fetch user data: $e'));
    }
  }
}