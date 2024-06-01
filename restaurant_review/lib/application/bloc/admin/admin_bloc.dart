import 'package:bloc/bloc.dart';
import 'package:restaurant_review/application/bloc/admin/admin_event.dart';
import 'package:restaurant_review/application/bloc/admin/admin_bloc.dart';
import 'package:restaurant_review/application/bloc/admin/admin_event.dart';
import 'package:restaurant_review/application/bloc/admin/admin_state.dart';
import 'package:restaurant_review/domain/entities/restaurant_entity.dart';
import 'package:restaurant_review/domain/entities/user_detail_entity.dart';
import 'package:restaurant_review/infrastructure/repository/admin_repository.dart';

class AdminBloc extends Bloc<AdminEvent, AdminState> {
  final AdminRepository adminRepository;

  AdminBloc({required this.adminRepository}) : super(AdminInitial()) {
    on<FetchUsers>((event, emit) async {
      emit(AdminLoading());
      try {
        //fetches all owners
        final owners = await adminRepository.fetch('owner');
        //fetches all customers
        final customers = await adminRepository.fetch('user');
        emit(AdminLoaded(owners: owners, customers: customers));
      } catch (e) {
        emit(AdminError(message: e.toString()));
        print('error in admin bloc: $e');
      }
    });

//BAN OR UNBAN CUSTOMER
    on<ToggleBanCustomer>((event, emit) async {
      final currentState = state;
      if (currentState is AdminLoaded) {
        try {
          if (event.isBanned == true) {
            await adminRepository.ban(event.username);
            print('user to be banned: ${event.username}');
          }
          if (event.isBanned == false) {
            await adminRepository.unban(event.username);
            print('user to be unbanned: ${event.username}');
          }

          final updatedCustomers = await adminRepository.fetch('user');

          emit(AdminLoaded(
              owners: currentState.owners, customers: updatedCustomers));
        } catch (e) {
          emit(AdminError(message: 'Failed to ban owner: ${e}'));
        }
      }
    });

// //UNBAN CUSTOMER
//     on<ToggleUnBanCustomer>((event, emit) async {
//       final currentState = state;
//       if (currentState is AdminLoaded) {
//         try {
//           await adminRepository
//               .unban(currentState.customers[event.index].username);
//           print(
//               'user to be banned: ${currentState.customers[event.index].username}');

//           final updatedCustomers =
//               List<UserDetail>.from(currentState.customers);
//           updatedCustomers[event.index] =
//               updatedCustomers[event.index].copyWith(isBanned: event.isBanned);

//           emit(AdminLoaded(
//               owners: updatedCustomers, customers: currentState.customers));
//         } catch (e) {
//           emit(AdminError(message: 'Failed to ban owner: ${e}'));
//         }
//       }
//     });

//BAN OWNERS
    on<ToggleBanOwner>((event, emit) async {
      final currentState = state;
      print('owner block attempt');
      if (currentState is AdminLoaded) {
        try {
          if (event.isBanned == true) {
            await adminRepository.ban(event.username);
            print('owner to be banned: ${event.username}');
          }
          if (event.isBanned == false) {
            await adminRepository.unban(event.username);
            print('owner to be unbanned: ${event.username}');
          }

          final updatedOwners = await adminRepository.fetch('owner');

          emit(AdminLoaded(
              owners: updatedOwners, customers: currentState.customers));
        } catch (e) {
          emit(AdminError(message: 'Failed to ban owner: ${e}'));
        }
      }
    });

// //UNBAN OWNERS
//     on<ToggleUnBanOwner>((event, emit) async {
//       final currentState = state;
//       print('owner block attempt');
//       if (currentState is AdminLoaded) {
//         try {
//           await adminRepository
//               .unban(currentState.owners[event.index].username);
//           print(
//               'user to be banned: ${currentState.owners[event.index].username}');

//           final updatedOwners = List<UserDetail>.from(currentState.owners);
//           updatedOwners[event.index] =
//               updatedOwners[event.index].copyWith(isBanned: event.isBanned);

//           emit(AdminLoaded(
//               owners: updatedOwners, customers: currentState.customers));
//         } catch (e) {
//           emit(AdminError(message: 'Failed to ban owner: ${e}'));
//         }
//       }
//     });
  }
}
