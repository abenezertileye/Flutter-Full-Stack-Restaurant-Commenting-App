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
        final owners = await adminRepository.fetchOwners();
        final customers = await adminRepository.fetchCustomers();
        emit(AdminLoaded(owners: owners, customers: customers));
      } catch (e) {
        emit(AdminError(message: e.toString()));
        print('error in admin bloc: $e');
      }
    });

    on<ToggleBanCustomer>((event, emit) async {
      final currentState = state;
      if (currentState is AdminLoaded) {
        final updatedCustomers = List<UserDetail>.from(currentState.customers);
        updatedCustomers[event.index] =
            updatedCustomers[event.index].copyWith(isBanned: event.isBanned);
        emit(AdminLoaded(
            owners: currentState.owners, customers: updatedCustomers));
      }
    });

    on<ToggleBanOwner>((event, emit) async {
      final currentState = state;
      print('owner block attempt');
      if (currentState is AdminLoaded) {
        try {
          await adminRepository
              .banOwners(currentState.owners[event.index].name);
          print('user to be banned: ${currentState.owners[event.index].name}');

          final updatedOwners = List<Restaurant>.from(currentState.owners);
          updatedOwners[event.index] =
              updatedOwners[event.index].copyWith(isBanned: event.isBanned);

          emit(AdminLoaded(
              owners: updatedOwners, customers: currentState.customers));
        } catch (e) {
          emit(AdminError(message: 'Failed to ban owner: ${e}'));
        }
      }
    });
  }
}
