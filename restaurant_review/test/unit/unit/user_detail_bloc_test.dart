import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:restaurant_review/domain/usecase/user_detail_usecase.dart';
import 'package:restaurant_review/application/bloc/user_detail_bloc/user_detail_bloc.dart';
import 'package:restaurant_review/application/bloc/user_detail_bloc/user_detail_event.dart';
import 'package:restaurant_review/application/bloc/user_detail_bloc/user_detail_state.dart';
import 'package:restaurant_review/domain/entities/user_detail_entity.dart';

import 'user_detail_usecase_test.mocks.dart';

void main() {
  late MockUserRepository mockUserRepository;
  late UserUseCase userUseCase;
  late UserBloc userBloc;

  setUp(() {
    mockUserRepository = MockUserRepository();
    userUseCase = UserUseCase(userRepository: mockUserRepository);
    userBloc = UserBloc(userUseCase: userUseCase);
  });

  group('UserBloc FetchUserRequested', () {
    final userDetail = UserDetail(
      id: '1',
      username: 'test_user',
      email: 'test@example.com',
      roles: [],
      isBanned: false,
      createdAt: '2021-01-01',
      updatedAt: '2021-01-01',
    );

    blocTest<UserBloc, UserState>(
      'emits [UserLoading, UserLoaded] when FetchUserRequested is added and fetchUserData is successful',
      build: () {
        when(mockUserRepository.fetchUser())
            .thenAnswer((_) async => userDetail);
        return userBloc;
      },
      act: (bloc) => bloc.add(FetchUserRequested()),
      expect: () => [
        isA<UserLoading>(),
        isA<UserLoaded>(),
      ],
    );

    blocTest<UserBloc, UserState>(
      'emits [UserLoading, UserError] when FetchUserRequested is added and fetchUserData fails',
      build: () {
        when(mockUserRepository.fetchUser())
            .thenThrow(Exception('Failed to fetch user'));
        return userBloc;
      },
      act: (bloc) => bloc.add(FetchUserRequested()),
      expect: () => [
        isA<UserLoading>(),
        isA<UserError>(),
      ],
    );
  });

  group('UserBloc UpdatePassword', () {
    const oldPassword = 'oldPassword';
    const newPassword = 'newPassword';
    const successMessage = 'Password Updated Successfully';

    blocTest<UserBloc, UserState>(
      'emits [PasswordUpdating, PasswordUpdated] when UpdatePassword is added and updatePassword is successful',
      build: () {
        when(mockUserRepository.updatePasswordReq(
                oldPassword: oldPassword, newPassword: newPassword))
            .thenAnswer((_) async => successMessage);
        return userBloc;
      },
      act: (bloc) => bloc.add(
          UpdatePassword(oldPassword: oldPassword, newPassword: newPassword)),
      expect: () => [
        isA<PasswordUpdating>(),
        isA<PasswordUpdated>(),
      ],
    );

    blocTest<UserBloc, UserState>(
      'emits [PasswordUpdating, UserError] when UpdatePassword is added and updatePassword fails',
      build: () {
        when(mockUserRepository.updatePasswordReq(
                oldPassword: oldPassword, newPassword: newPassword))
            .thenThrow(Exception('Failed to update password'));
        return userBloc;
      },
      act: (bloc) => bloc.add(
          UpdatePassword(oldPassword: oldPassword, newPassword: newPassword)),
      expect: () => [
        isA<PasswordUpdating>(),
        isA<UserError>(),
      ],
    );
  });

  group('UserBloc UpdateUsername', () {
    const username = 'newUsername';
    const successMessage = 'Username Updated Successfully';

    blocTest<UserBloc, UserState>(
      'emits [UsernameUpdating, UsernameUpdated] when UpdateUsername is added and updateUsername is successful',
      build: () {
        when(mockUserRepository.updateUsernameReq(username: username))
            .thenAnswer((_) async => successMessage);
        return userBloc;
      },
      act: (bloc) => bloc.add(UpdateUsername(username: username)),
      expect: () => [
        isA<UsernameUpdating>(),
        isA<UsernameUpdated>(),
      ],
    );

    blocTest<UserBloc, UserState>(
      'emits [UsernameUpdating, UserError] when UpdateUsername is added and updateUsername fails',
      build: () {
        when(mockUserRepository.updateUsernameReq(username: username))
            .thenThrow(Exception('Failed to update username'));
        return userBloc;
      },
      act: (bloc) => bloc.add(UpdateUsername(username: username)),
      expect: () => [
        isA<UsernameUpdating>(),
        isA<UserError>(),
      ],
    );
  });

  group('UserBloc DeleteAccount', () {
    const successMessage = 'Account Deleted Successfully';

    blocTest<UserBloc, UserState>(
      'emits [DeletingAccount, AccountDeleted] when DeleteAccount is added and deleteAccount is successful',
      build: () {
        when(mockUserRepository.deleteAccountReq())
            .thenAnswer((_) async => successMessage);
        return userBloc;
      },
      act: (bloc) => bloc.add(DeleteAccount()),
      expect: () => [
        isA<DeletingAccount>(),
        isA<AccountDeleted>(),
      ],
    );

    blocTest<UserBloc, UserState>(
      'emits [DeletingAccount, UserError] when DeleteAccount is added and deleteAccount fails',
      build: () {
        when(mockUserRepository.deleteAccountReq())
            .thenThrow(Exception('Failed to delete account'));
        return userBloc;
      },
      act: (bloc) => bloc.add(DeleteAccount()),
      expect: () => [
        isA<DeletingAccount>(),
        isA<UserError>(),
      ],
    );
  });
}
