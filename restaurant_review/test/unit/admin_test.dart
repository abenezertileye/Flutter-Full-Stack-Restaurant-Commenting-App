import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:restaurant_review/application/bloc/admin/admin_bloc.dart';
import 'package:restaurant_review/application/bloc/admin/admin_event.dart';
import 'package:restaurant_review/application/bloc/admin/admin_state.dart';
import 'package:restaurant_review/domain/entities/user_detail_entity.dart';
import 'package:restaurant_review/infrastructure/repository/admin_repository.dart';

// Mock class
class MockAdminRepository extends Mock implements AdminRepository {}

void main() {
  group('AdminBloc Tests', () {
    late AdminBloc adminBloc;
    late MockAdminRepository mockAdminRepository;

    setUp(() {
      mockAdminRepository = MockAdminRepository();
      adminBloc = AdminBloc(adminRepository: mockAdminRepository);
    });

    test('FetchUsers emits AdminLoaded when fetch is successful', () async {
      // Arrange
      final List<UserDetail> mockOwners = [
        UserDetail(
          id: '1',
          username: 'owner1',
          email: 'owner1@example.com',
          roles: ['owner'],
          isBanned: false,
          createdAt: '2023-01-01',
          updatedAt: '2023-01-01',
        ),
      ];
      final List<UserDetail> mockCustomers = [
        UserDetail(
          id: '2',
          username: 'customer1',
          email: 'customer1@example.com',
          roles: ['user'],
          isBanned: false,
          createdAt: '2023-01-01',
          updatedAt: '2023-01-01',
        ),
      ];
      when(mockAdminRepository.fetch('owner'))
          .thenAnswer((_) async => mockOwners);
      when(mockAdminRepository.fetch('user'))
          .thenAnswer((_) async => mockCustomers);

      // Act
      adminBloc.add(FetchUsers());

      // Assert
      await expectLater(
        adminBloc,
        emitsInOrder([
          AdminLoading(),
          AdminLoaded(owners: mockOwners, customers: mockCustomers)
        ]),
      );
    });

    test('FetchUsers emits AdminError when fetch fails', () async {
      // Arrange
      when(mockAdminRepository.fetch(any))
          .thenThrow(Exception('Failed to fetch owners'));

      // Act
      adminBloc.add(FetchUsers());

      // Assert
      await expectLater(
        adminBloc,
        emitsInOrder([
          AdminLoading(),
          AdminError(message: 'Exception: Failed to fetch owners')
        ]),
      );
    });
  });
}
