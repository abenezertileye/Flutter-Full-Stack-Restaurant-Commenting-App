import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:restaurant_review/domain/entities/user_entity.dart';
import 'package:restaurant_review/infrastructure/repository/auth_repository.dart';
import 'package:restaurant_review/domain/usecase/auth_usecase.dart';
import 'package:restaurant_review/models/user_types.dart';

import 'auth_usecase_test.mocks.dart';

@GenerateMocks([AuthRepository])
void main() {
  late MockAuthRepository mockAuthRepository;
  late AuthUseCase authUseCase;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    authUseCase = AuthUseCase(authRepository: mockAuthRepository);
  });

  group('AuthUseCase', () {
    final user = User(
      access_token: 'token',
      roles: ['user'],
      id: '123',
    );

    test('signup should return a User on successful signup', () async {
      // Arrange
      when(mockAuthRepository.signUp(
        username: anyNamed('username'),
        email: anyNamed('email'),
        password: anyNamed('password'),
        userType: anyNamed('userType'),
      )).thenAnswer((_) async => user);

      // Act
      final result = await authUseCase.signup(
        username: 'testuser',
        email: 'test@example.com',
        password: 'password',
        userType: UserType.user,
      );

      // Assert
      expect(result, user);
      verify(mockAuthRepository.signUp(
        username: 'testuser',
        email: 'test@example.com',
        password: 'password',
        userType: UserType.user,
      )).called(1);
    });

    test('login should return a User on successful login', () async {
      // Arrange
      when(mockAuthRepository.login(
        username: anyNamed('username'),
        password: anyNamed('password'),
      )).thenAnswer((_) async => user);

      // Act
      final result = await authUseCase.login(
        username: 'testuser',
        password: 'password',
      );

      // Assert
      expect(result, user);
      verify(mockAuthRepository.login(
        username: 'testuser',
        password: 'password',
      )).called(1);
    });
  });
}
