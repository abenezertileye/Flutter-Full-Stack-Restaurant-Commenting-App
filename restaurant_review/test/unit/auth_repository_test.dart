// import 'dart:convert';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/mockito.dart';
// import 'package:http/http.dart' as http;
// import 'package:restaurant_review/infrastructure/repository/auth_repository.dart';
// import 'package:restaurant_review/data/storage.dart';
// import 'package:restaurant_review/domain/entities/user_entity.dart';
// import 'dart:convert';

// // Mock Classes
// class MockClient extends Mock implements http.Client {}
// class MockSecureStorage extends Mock implements SecureStorage {}

// void main() {
//   late AuthRepository authRepository;
//   late MockClient mockClient;
//   late MockSecureStorage mockSecureStorage;
//   setUp(() {
//     mockClient = MockClient();
//     mockSecureStorage = MockSecureStorage();
//     authRepository = AuthRepository();
//     authRepository.client = mockClient; // Set the mock client
//     authRepository.secureStorage = mockSecureStorage; // Set the mock secure storage
//   });

//   group('AuthRepository', () {
//     group('signUp', () {
//       test('returns User if the sign up is successful', () async {
//         final userType = User;
//         final responseJson = {
//           'access_token': 'mock_token',
//           'roles': ['user'],
//           '_id': '1',
//         };

//         when(mockClient.post(
//           Uri.parse('http://localhost:3000/auth/signup'),
//           headers: anyNamed('headers'),
//           body: anyNamed('body'),
//         )).thenAnswer((_) async => http.Response(jsonEncode(responseJson), 201));

//         final user = await authRepository.signUp(
//           username: 'testuser',
//           email: 'test@example.com',
//           password: 'password',
//           userType: userType,
//         );

//         expect(user, isA<User>());
//         expect(user.access_token, 'mock_token');
//         expect(user.roles, ['user']);
//         expect(user.id, '1');
//       });

//       test('throws an exception if the sign up fails', () {
//         when(mockClient.post(
//           Uri.parse('http://localhost:3000/auth/signup'),
//           headers: anyNamed('headers'),
//           body: anyNamed('body'),
//         )).thenAnswer((_) async => http.Response('Unauthorized', 401));

//         expect(
//           authRepository.signUp(
//             username: 'testuser',
//             email: 'test@example.com',
//             password: 'password',
//             userType: UserType.user,
//           ),
//           throwsA(isA<Exception>()),
//         );
//       });
//     });

//     group('login', () {
//       test('returns User and stores token if the login is successful', () async {
//         final responseJson = {
//           'access_token': 'mock_token',
//           'roles': ['user'],
//           '_id': '1',
//         };

//         when(mockClient.post(
//           Uri.parse('http://localhost:3000/auth/login'),
//           headers: anyNamed('headers'),
//           body: anyNamed('body'),
//         )).thenAnswer((_) async => http.Response(jsonEncode(responseJson), 201));

//         when(mockSecureStorage.write(any, any))
//             .thenAnswer((_) async => Future.value());

//         final user = await authRepository.login(
//           username: 'testuser',
//           password: 'password',
//         );

//         expect(user, isA<User>());
//         expect(user.access_token, 'mock_token');
//         expect(user.roles, ['user']);
//         expect(user.id, '1');
//         verify(mockSecureStorage.write('token', 'mock_token')).called(1);
//       });

//       test('throws an exception if the login fails', () {
//         when(mockClient.post(
//           Uri.parse('http://localhost:3000/auth/login'),
//           headers: anyNamed('headers'),
//           body: anyNamed('body'),
//         )).thenAnswer((_) async => http.Response('Unauthorized', 401));

//         expect(
//           authRepository.login(
//             username: 'testuser',
//             password: 'password',
//           ),
//           throwsA(isA<Exception>()),
//         );
//       });
//     });
//   });
// }