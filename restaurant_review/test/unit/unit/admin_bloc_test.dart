import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:restaurant_review/application/bloc/admin/admin_bloc.dart';
import 'package:restaurant_review/application/bloc/admin/admin_event.dart';
import 'package:restaurant_review/application/bloc/admin/admin_state.dart';
import 'package:restaurant_review/domain/entities/user_detail_entity.dart';
import 'package:restaurant_review/infrastructure/repository/admin_repository.dart';

import 'admin_bloc_test.mocks.dart';

@GenerateMocks([AdminRepository])
void main() {
  late MockAdminRepository mockAdminRepository;
  late AdminBloc adminBloc;

  setUp(() {
    mockAdminRepository = MockAdminRepository();
    adminBloc = AdminBloc(adminRepository: mockAdminRepository);
  });

  group('AdminBloc FetchUsers', () {
    final owners = [
      UserDetail(
        id: '1',
        username: 'owner1',
        email: 'owner1@example.com',
        roles: ['owner'],
        isBanned: false,
        createdAt: '2021-01-01',
        updatedAt: '2021-01-01',
      ),
    ];

    final customers = [
      UserDetail(
        id: '2',
        username: 'customer1',
        email: 'customer1@example.com',
        roles: ['user'],
        isBanned: false,
        createdAt: '2021-01-01',
        updatedAt: '2021-01-01',
      ),
    ];

    blocTest<AdminBloc, AdminState>(
      'emits [AdminLoading, AdminLoaded] when FetchUsers is added and fetch is successful',
      build: () {
        when(mockAdminRepository.fetch('owner'))
            .thenAnswer((_) async => owners);
        when(mockAdminRepository.fetch('user'))
            .thenAnswer((_) async => customers);
        return adminBloc;
      },
      act: (bloc) => bloc.add(FetchUsers()),
      expect: () => [
        isA<AdminLoading>(),
        isA<AdminLoaded>(),
      ],
    );

    blocTest<AdminBloc, AdminState>(
      'emits [AdminLoading, AdminError] when FetchUsers is added and fetch fails',
      build: () {
        when(mockAdminRepository.fetch(any))
            .thenThrow(Exception('Failed to fetch users'));
        return adminBloc;
      },
      act: (bloc) => bloc.add(FetchUsers()),
      expect: () => [
        isA<AdminLoading>(),
        isA<AdminError>(),
      ],
    );
  });

  group('AdminBloc ToggleBanCustomer', () {
    final customers = [
      UserDetail(
        id: '2',
        username: 'customer1',
        email: 'customer1@example.com',
        roles: ['user'],
        isBanned: false,
        createdAt: '2021-01-01',
        updatedAt: '2021-01-01',
      ),
    ];

    final updatedCustomers = [
      UserDetail(
        id: '2',
        username: 'customer1',
        email: 'customer1@example.com',
        roles: ['user'],
        isBanned: true,
        createdAt: '2021-01-01',
        updatedAt: '2021-01-01',
      ),
    ];

    blocTest<AdminBloc, AdminState>(
      'emits [AdminLoaded] with updated customers list when ToggleBanCustomer is added and ban/unban is successful',
      build: () {
        when(mockAdminRepository.fetch('user'))
            .thenAnswer((_) async => customers);
        when(mockAdminRepository.ban('customer1'))
            .thenAnswer((_) async => 'Customer Banned Successfully');
        when(mockAdminRepository.fetch('user'))
            .thenAnswer((_) async => updatedCustomers);
        return adminBloc
          ..emit(AdminLoaded(owners: const [], customers: customers));
      },
      act: (bloc) =>
          bloc.add(ToggleBanCustomer(username: 'customer1', isBanned: true)),
      expect: () => [
        isA<AdminLoaded>(),
      ],
    );

    blocTest<AdminBloc, AdminState>(
      'emits [AdminError] when ToggleBanCustomer is added and ban fails',
      build: () {
        when(mockAdminRepository.ban('customer1'))
            .thenThrow(Exception('Failed to ban user'));
        return adminBloc
          ..emit(AdminLoaded(owners: const [], customers: customers));
      },
      act: (bloc) =>
          bloc.add(ToggleBanCustomer(username: 'customer1', isBanned: true)),
      expect: () => [
        isA<AdminError>(),
      ],
    );
  });

  group('AdminBloc ToggleBanOwner', () {
    final owners = [
      UserDetail(
        id: '1',
        username: 'owner1',
        email: 'owner1@example.com',
        roles: ['owner'],
        isBanned: false,
        createdAt: '2021-01-01',
        updatedAt: '2021-01-01',
      ),
    ];

    final updatedOwners = [
      UserDetail(
        id: '1',
        username: 'owner1',
        email: 'owner1@example.com',
        roles: ['owner'],
        isBanned: true,
        createdAt: '2021-01-01',
        updatedAt: '2021-01-01',
      ),
    ];

    blocTest<AdminBloc, AdminState>(
      'emits [AdminLoaded] with updated owners list when ToggleBanOwner is added and ban/unban is successful',
      build: () {
        when(mockAdminRepository.fetch('owner'))
            .thenAnswer((_) async => owners);
        when(mockAdminRepository.ban('owner1'))
            .thenAnswer((_) async => 'Owner Banned Successfully');
        when(mockAdminRepository.fetch('owner'))
            .thenAnswer((_) async => updatedOwners);
        return adminBloc
          ..emit(AdminLoaded(owners: owners, customers: const []));
      },
      act: (bloc) =>
          bloc.add(ToggleBanOwner(username: 'owner1', isBanned: true)),
      expect: () => [
        isA<AdminLoaded>(),
      ],
    );

    blocTest<AdminBloc, AdminState>(
      'emits [AdminError] when ToggleBanOwner is added and ban fails',
      build: () {
        when(mockAdminRepository.ban('owner1'))
            .thenThrow(Exception('Failed to ban owner'));
        return adminBloc
          ..emit(AdminLoaded(owners: owners, customers: const []));
      },
      act: (bloc) =>
          bloc.add(ToggleBanOwner(username: 'owner1', isBanned: true)),
      expect: () => [
        isA<AdminError>(),
      ],
    );
  });
}
