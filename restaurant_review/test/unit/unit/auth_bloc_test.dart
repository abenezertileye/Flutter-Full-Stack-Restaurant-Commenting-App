import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:restaurant_review/application/bloc/auth_bloc/auth_bloc.dart';
import 'package:restaurant_review/application/bloc/auth_bloc/auth_events.dart';
import 'package:restaurant_review/application/bloc/auth_bloc/auth_state.dart';
import 'package:restaurant_review/domain/usecase/auth_usecase.dart';
import 'package:restaurant_review/domain/entities/user_entity.dart';
import 'package:restaurant_review/models/user_types.dart';

import 'auth_bloc_test.mocks.dart';

@GenerateMocks([AuthUseCase])
void main() {
  late MockAuthUseCase mockAuthUseCase;
  late AuthBloc authBloc;

  setUp(() {
    mockAuthUseCase = MockAuthUseCase();
    authBloc = AuthBloc(authUseCase: mockAuthUseCase);
  });

  group('AuthBloc', () {
    final user = User(
      access_token: 'token',
      roles: ['user'],
      id: '123',
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthSuccess] when SignUpButtonPressed is added and signup is successful',
      build: () {
        when(mockAuthUseCase.signup(
          username: anyNamed('username'),
          email: anyNamed('email'),
          password: anyNamed('password'),
          userType: anyNamed('userType'),
        )).thenAnswer((_) async => user);
        return authBloc;
      },
      act: (bloc) => bloc.add(SignUpButtonPressed(
        username: 'testuser',
        email: 'test@example.com',
        password: 'password',
        userType: UserType.user,
      )),
      expect: () => [
        isA<AuthLoading>(),
        isA<AuthSuccess>().having((s) => s.user, 'user', user),
      ],
      verify: (_) {
        verify(mockAuthUseCase.signup(
          username: 'testuser',
          email: 'test@example.com',
          password: 'password',
          userType: UserType.user,
        )).called(1);
      },
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthFailure] when SignUpButtonPressed is added and signup fails',
      build: () {
        when(mockAuthUseCase.signup(
          username: anyNamed('username'),
          email: anyNamed('email'),
          password: anyNamed('password'),
          userType: anyNamed('userType'),
        )).thenThrow(Exception('Signup failed'));
        return authBloc;
      },
      act: (bloc) => bloc.add(SignUpButtonPressed(
        username: 'testuser',
        email: 'test@example.com',
        password: 'password',
        userType: UserType.user,
      )),
      expect: () => [
        isA<AuthLoading>(),
        isA<AuthFailure>().having((f) => f.error, 'error',
            'Failed to sign up: Exception: Signup failed'),
      ],
      verify: (_) {
        verify(mockAuthUseCase.signup(
          username: 'testuser',
          email: 'test@example.com',
          password: 'password',
          userType: UserType.user,
        )).called(1);
      },
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthSuccess] when LogInButtonPressed is added and login is successful',
      build: () {
        when(mockAuthUseCase.login(
          username: anyNamed('username'),
          password: anyNamed('password'),
        )).thenAnswer((_) async => user);
        return authBloc;
      },
      act: (bloc) => bloc.add(LogInButtonPressed(
        username: 'testuser',
        password: 'password',
      )),
      expect: () => [
        isA<AuthLoading>(),
        isA<AuthSuccess>().having((s) => s.user, 'user', user),
      ],
      verify: (_) {
        verify(mockAuthUseCase.login(
          username: 'testuser',
          password: 'password',
        )).called(1);
      },
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthFailure] when LogInButtonPressed is added and login fails',
      build: () {
        when(mockAuthUseCase.login(
          username: anyNamed('username'),
          password: anyNamed('password'),
        )).thenThrow(Exception('Login failed'));
        return authBloc;
      },
      act: (bloc) => bloc.add(LogInButtonPressed(
        username: 'testuser',
        password: 'password',
      )),
      expect: () => [
        isA<AuthLoading>(),
        isA<AuthFailure>().having((f) => f.error, 'error',
            'Failed to sign up: Exception: Login failed'),
      ],
      verify: (_) {
        verify(mockAuthUseCase.login(
          username: 'testuser',
          password: 'password',
        )).called(1);
      },
    );

    blocTest<AuthBloc, AuthState>(
      'emits [UserTypeUpdated] when UserTypeSelected is added',
      build: () => authBloc,
      act: (bloc) => bloc.add(UserTypeSelected(userType: UserType.owner)),
      expect: () => [
        isA<UserTypeUpdated>()
            .having((s) => s.userType, 'userType', UserType.owner),
      ],
    );
  });
}
