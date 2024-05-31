import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:restaurant_review/domain/entities/user_detail_entity.dart';
import 'package:restaurant_review/infrastructure/repository/user_detail_repository.dart';
import 'package:restaurant_review/domain/usecase/user_detail_usecase.dart';

import 'user_detail_usecase_test.mocks.dart';

@GenerateMocks([UserRepository])
void main() {
  late MockUserRepository mockUserRepository;
  late UserUseCase userUseCase;

  setUp(() {
    mockUserRepository = MockUserRepository();
    userUseCase = UserUseCase(userRepository: mockUserRepository);
  });

  group('fetchUserData', () {
    final userDetail = UserDetail(
      id: '1',
      username: 'test_user',
      email: 'test@example.com',
      roles: [],
      isBanned: false,
      createdAt: '2021-01-01',
      updatedAt: '2021-01-01',
    );

    test('should return UserDetail when fetchUser is successful', () async {
      // Arrange
      when(mockUserRepository.fetchUser()).thenAnswer((_) async => userDetail);

      // Act
      final result = await userUseCase.fetchUserData();

      // Assert
      expect(result, userDetail);
      verify(mockUserRepository.fetchUser()).called(1);
    });

    test('should throw an exception when fetchUser fails', () async {
      // Arrange
      when(mockUserRepository.fetchUser())
          .thenThrow(Exception('Failed to fetch user'));

      // Act
      final call = userUseCase.fetchUserData;

      // Assert
      expect(() => call(), throwsException);
      verify(mockUserRepository.fetchUser()).called(1);
    });
  });

  group('updatePassword', () {
    const oldPassword = 'oldPassword';
    const newPassword = 'newPassword';
    const successMessage = 'Password Updated Successfully';

    test('should return success message when updatePasswordReq is successful',
        () async {
      // Arrange
      when(mockUserRepository.updatePasswordReq(
              oldPassword: oldPassword, newPassword: newPassword))
          .thenAnswer((_) async => successMessage);

      // Act
      final result = await userUseCase.updatePassword(
          oldPassword: oldPassword, newPassword: newPassword);

      // Assert
      expect(result, successMessage);
      verify(mockUserRepository.updatePasswordReq(
              oldPassword: oldPassword, newPassword: newPassword))
          .called(1);
    });

    test('should throw an exception when updatePasswordReq fails', () async {
      // Arrange
      when(mockUserRepository.updatePasswordReq(
              oldPassword: oldPassword, newPassword: newPassword))
          .thenThrow(Exception('Failed to update password'));

      // Act
      final call = userUseCase.updatePassword;

      // Assert
      expect(() => call(oldPassword: oldPassword, newPassword: newPassword),
          throwsException);
      verify(mockUserRepository.updatePasswordReq(
              oldPassword: oldPassword, newPassword: newPassword))
          .called(1);
    });
  });

  group('updateUsername', () {
    const username = 'newUsername';
    const successMessage = 'Username Updated Successfully';

    test('should return success message when updateUsernameReq is successful',
        () async {
      // Arrange
      when(mockUserRepository.updateUsernameReq(username: username))
          .thenAnswer((_) async => successMessage);

      // Act
      final result = await userUseCase.updateUsername(username: username);

      // Assert
      expect(result, successMessage);
      verify(mockUserRepository.updateUsernameReq(username: username))
          .called(1);
    });

    test('should throw an exception when updateUsernameReq fails', () async {
      // Arrange
      when(mockUserRepository.updateUsernameReq(username: username))
          .thenThrow(Exception('Failed to update username'));

      // Act
      final call = userUseCase.updateUsername;

      // Assert
      expect(() => call(username: username), throwsException);
      verify(mockUserRepository.updateUsernameReq(username: username))
          .called(1);
    });
  });

  group('deleteAccount', () {
    const successMessage = 'Account Deleted Successfully';

    test('should return success message when deleteAccountReq is successful',
        () async {
      // Arrange
      when(mockUserRepository.deleteAccountReq())
          .thenAnswer((_) async => successMessage);

      // Act
      final result = await userUseCase.deleteAccount();

      // Assert
      expect(result, successMessage);
      verify(mockUserRepository.deleteAccountReq()).called(1);
    });

    test('should throw an exception when deleteAccountReq fails', () async {
      // Arrange
      when(mockUserRepository.deleteAccountReq())
          .thenThrow(Exception('Failed to delete account'));

      // Act
      final call = userUseCase.deleteAccount;

      // Assert
      expect(() => call(), throwsException);
      verify(mockUserRepository.deleteAccountReq()).called(1);
    });
  });
}
