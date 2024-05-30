import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_review/application/bloc/admin/admin_bloc.dart';
import 'package:restaurant_review/application/bloc/admin/admin_event.dart';
import 'package:restaurant_review/application/bloc/admin/admin_state.dart';
import 'package:restaurant_review/core/theme/app_pallete.dart';
import 'package:restaurant_review/infrastructure/repository/admin_repository.dart';
import 'package:restaurant_review/presentation/widgets/users_view_for_admin.dart';

class AdminTab extends StatefulWidget {
  const AdminTab({super.key});

  @override
  _AdminTabState createState() => _AdminTabState();
}

class _AdminTabState extends State<AdminTab> {
  late AdminBloc _adminBloc;

  @override
  void initState() {
    super.initState();
    _adminBloc = AdminBloc(adminRepository: AdminRepository());
    _adminBloc.add(FetchUsers());
  }

  void toggleBanCustomer(String username, bool value) {
    print(value);
    _adminBloc.add(ToggleBanCustomer(username: username, isBanned: value));
  }

  void toggleBanOwner(String username, bool value) {
    print(value);

    _adminBloc.add(ToggleBanOwner(username: username, isBanned: value));
  }

  @override
  void dispose() {
    _adminBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _adminBloc,
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              "Control Panel",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: AppPallete.blackColor,
              ),
            ),
            centerTitle: true,
            bottom: const TabBar(tabs: [
              Tab(
                icon: Icon(Icons.person_outlined),
                text: "Owners",
              ),
              Tab(
                icon: Icon(Icons.person_outlined),
                text: "Customers",
              )
            ]),
          ),
          body: BlocBuilder<AdminBloc, AdminState>(
            builder: (context, state) {
              if (state is AdminLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is AdminError) {
                return Center(child: Text(state.message));
              } else if (state is AdminLoaded) {
                return TabBarView(children: [
                  ListView.builder(
                    itemCount: state.owners.length,
                    itemBuilder: (context, index) => UsersView(
                      name: state.owners[index].username,
                      isBanned: state.owners[index].isBanned,
                      onChanged: (value) =>
                          toggleBanOwner(state.owners[index].username, value),
                    ),
                  ),
                  ListView.builder(
                    itemCount: state.customers.length,
                    itemBuilder: (context, index) => UsersView(
                      name: state.customers[index].username,
                      isBanned: state.customers[index].isBanned,
                      onChanged: (value) => toggleBanCustomer(
                          state.customers[index].username, value),
                    ),
                  ),
                ]);
              } else {
                return const Center(child: Text("No data"));
              }
            },
          ),
        ),
      ),
    );
  }
}
