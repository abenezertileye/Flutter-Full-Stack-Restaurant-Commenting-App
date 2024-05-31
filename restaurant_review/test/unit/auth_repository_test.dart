// import 'dart:convert';
// import 'package:test/test.dart';
// import 'package:http/http.dart' as http;
// import 'package:mockito/mockito.dart';
// import 'package:restaurant_review/models/user_types.dart';
// import 'package:restaurant_review/domain/entities/user_entity.dart';
// import 'package:restaurant_review/data/storage.dart';
// import 'package:restaurant_review/infrastructure/repository/auth_repository.dart';

// // Mocking HTTP client
// class MockClient extends Mock implements http.Client {}

// void main() {
//   group('AuthRepository', () {
//     late AuthRepository authRepository;
//     late MockClient mockClient;

//     setUp(() {
//       mockClient = MockClient();
//       authRepository = AuthRepository();
//       authRepository.httpClient = mockClient; // Injecting the mock client
//     });

//     test('signUp - success', () async {
//       final expectedUser = User(
//         access_token: 'token',
//         roles: ['user'],
//         id: '1',
//       );

//       when(mockClient.post(any,
//               headers: anyNamed('headers'), body: anyNamed('body')))
//           .thenAnswer((_) async =>
//               http.Response(jsonEncode(expectedUser.toJson()), 201));

//       final user = await authRepository.signUp(
//         username: 'testuser',
//         email: 'test@example.com',
//         password: 'password',
//         userType: UserType.user,
//       );

//       expect(user, equals(expectedUser));
//     });

//     test('login - success', () async {
//       final expectedUser = User(
//         accessToken: 'token',
//         roles: ['user'],
//         id: '1',
//       );

//       when(mockClient.post(any,
//               headers: anyNamed('headers'), body: anyNamed('body')))
//           .thenAnswer((_) async =>
//               http.Response(jsonEncode(expectedUser.toJson()), 201));

//       final user = await authRepository.login(
//         username: 'testuser',
//         password: 'password',
//       );

//       expect(user, equals(expectedUser));
//     });
//   });
// }
