// import 'package:bloc_test/bloc_test.dart';
// import 'package:mockito/mockito.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:restaurant_review/application/bloc/admin/admin_bloc.dart';
// import 'package:restaurant_review/application/bloc/admin/admin_event.dart';
// import 'package:restaurant_review/application/bloc/admin/admin_state.dart';
// import 'package:restaurant_review/domain/entities/user_detail_entity.dart';
// import 'package:restaurant_review/infrastructure/repository/admin_repository.dart';

// // Mock class
// class MockAdminRepository extends Mock implements AdminRepository {}

// void main() {
//   late MockAdminRepository mockAdminRepository;
//   late AdminBloc adminBloc;

//   setUp(() {
//     mockAdminRepository = MockAdminRepository();
//     adminBloc = AdminBloc(adminRepository: mockAdminRepository);
//   });

//   tearDown(() {
//     adminBloc.close();
//   });

//   group('AdminBloc Tests', () {
//     final List<UserDetail> mockOwners = [
//       UserDetail(
//         id: '1',
//         username: 'owner1',
//         email: 'owner1@example.com',
//         roles: ['owner'],
//         isBanned: false,
//         createdAt: '2023-01-01',
//         updatedAt: '2023-01-01',
//       ),
//     ];

//     final List<UserDetail> mockCustomers = [
//       UserDetail(
//         id: '2',
//         username: 'customer1',
//         email: 'customer1@example.com',
//         roles: ['user'],
//         isBanned: false,
//         createdAt: '2023-01-01',
//         updatedAt: '2023-01-01',
//       ),
//     ];

//     blocTest<AdminBloc, AdminState>(
//       'emits [AdminLoading, AdminLoaded] when FetchUsers is added and fetch is successful',
//       build: () {
//         when(mockAdminRepository.fetch('owner')).thenAnswer((_) async => mockOwners);
//         when(mockAdminRepository.fetch('user')).thenAnswer((_) async => mockCustomers);
//         return adminBloc;
//       },
//       act: (bloc) => bloc.add(FetchUsers()),
//       expect: () => [
//         AdminLoading(),
//         AdminLoaded(owners: mockOwners, customers: mockCustomers),
//       ],
//     );

//     blocTest<AdminBloc, AdminState>(
//       'emits [AdminLoading, AdminError] when FetchUsers is added and fetch fails',
//       build: () {
//         when(mockAdminRepository.fetch('owner')).thenThrow(Exception('Failed to fetch owners'));
//         when(mockAdminRepository.fetch('user')).thenThrow(Exception('Failed to fetch customers'));
//         return adminBloc;
//       },
//       act: (bloc) => bloc.add(FetchUsers()),
//       expect: () => [
//         AdminLoading(),
//         AdminError(message: 'Exception: Failed to fetch owners'),
//       ],
//     );

//     blocTest<AdminBloc, AdminState>(
//       'emits [AdminLoaded] with updated customers when ToggleBanCustomer is added and succeeds',
//       build: () {
//         when(mockAdminRepository.ban('customer1')).thenAnswer((_) async => 'Customer Banned Successfully');
//         when(mockAdminRepository.fetch('user')).thenAnswer((_) async => mockCustomers);
//         return adminBloc;
//       },
//       seed: () => AdminLoaded(owners: mockOwners, customers: mockCustomers),
//       act: (bloc) => bloc.add(ToggleBanCustomer(username: 'customer1', isBanned: true)),
//       expect: () => [
//         AdminLoaded(owners: mockOwners, customers: mockCustomers),
//       ],
//     );

//     blocTest<AdminBloc, AdminState>(
//       'emits [AdminError] when ToggleBanCustomer is added and ban fails',
//       build: () {
//         when(mockAdminRepository.ban('customer1')).thenThrow(Exception('Failed to ban customer'));
//         return adminBloc;
//       },
//       seed: () => AdminLoaded(owners: mockOwners, customers: mockCustomers),
//       act: (bloc) => bloc.add(ToggleBanCustomer(username: 'customer1', isBanned: true)),
//       expect: () => [
//         AdminError(message: 'Failed to ban owner: Exception: Failed to ban customer'),
//       ],
//     );
//   });
// }
