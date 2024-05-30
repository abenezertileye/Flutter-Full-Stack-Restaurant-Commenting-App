import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_review/application/bloc/user_detail_bloc/user_detail_event.dart';
import 'package:restaurant_review/application/bloc/user_detail_bloc/user_detail_bloc.dart';
import 'package:restaurant_review/presentation/screens/modal_form.dart';
import 'package:restaurant_review/presentation/screens/home_page.dart';
import 'package:restaurant_review/domain/usecase/user_detail_usecase.dart';
import 'package:restaurant_review/domain/entities/user_detail_entity.dart';
import 'package:restaurant_review/infrastructure/repository/user_detail_repository.dart';
import 'package:restaurant_review/application/bloc/user_detail_bloc/user_detail_state.dart';
import 'package:restaurant_review/domain/entities/user_entity.dart';
import 'package:restaurant_review/presentation/screens/sign_up_page.dart';
import '../widgets/text_fields.dart';
import '../widgets/logout.dart';
import '../widgets/expansion_bar.dart';
import '../widgets/user_info.dart';
import 'package:restaurant_review/data/storage.dart';
import 'package:jwt_decode/jwt_decode.dart';

class ProfilePage extends StatelessWidget {
  final SecureStorage _secureStorage = SecureStorage.instance;

  // Future<String?> _fetchUserId() async {
  //   try {
  //     String? token = await _secureStorage.read('token');
  //     if (token != null) {
  //       Map<String, dynamic> payload = Jwt.parseJwt(token);
  //       print('id from token in profile page: ${payload['id']}');
  //       return payload['id'];
  //     }
  //   } catch (e) {
  //     print('Error fetching token: $e');
  //   }
  //   return null;
  // }

  // final userId = _fetchUserId();
  final userUseCase = UserUseCase(userRepository: UserRepository());
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          UserBloc(userUseCase: userUseCase)..add(FetchUserRequested()),
      child: ProfileView(),
    );
  }
}

class ProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        if (state is AccountDeleted) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => SignUpPage(),
            ),
          );
        }
        if (state is UserError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }

        if (state is PasswordUpdated) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ReviewHome(),
            ),
          );
        }
      },
      child: BlocBuilder<UserBloc, UserState>(
        builder: (context, userState) {
          Widget body;
          if (userState is UserInitial || userState is UserLoading) {
            body = const Center(child: CircularProgressIndicator());
          } else if (userState is UserLoaded) {
            final user = userState.user;
            body = DefaultTabController(
              length: user.roles[0] == 'owner' ? 2 : 1,
              child: Scaffold(
                appBar: AppBar(
                  title: Text(
                    "Edit and View Profile",
                    style: Theme.of(context)
                        .textTheme
                        .displayMedium!
                        .copyWith(color: Colors.black),
                  ),
                  centerTitle: true,
                  bottom: TabBar(
                    indicatorColor: Theme.of(context).colorScheme.primary,
                    labelColor: Theme.of(context).colorScheme.primary,
                    tabs: [
                      Tab(icon: Icon(Icons.person_outlined)),
                      if (user.roles[0] == 'owner')
                        Tab(icon: Icon(Icons.mode_edit_outline_outlined)),
                    ],
                  ),
                ),
                body: TabBarView(
                  children: [
                    Profile(user: user),
                    if (user.roles[0] == 'owner') Modal(),
                  ],
                ),
              ),
            );
          } else if (userState is UserError) {
            body = Center(child: Text('Error: ${userState.message}'));
          } else {
            body = const Center(child: CircularProgressIndicator());
          }
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: body,
          );
        },
      ),
    );
  }
}

class Profile extends StatelessWidget {
  final UserDetail user;

  Profile({required this.user});
  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(40),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: ListTile(
                leading: CircleAvatar(
                  radius: 30,
                  backgroundImage:
                      AssetImage('assets/images/default_profile.jpg'),
                ),
                title: Text(
                  user.username,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
                ),
                subtitle: Text(
                  'Joined ${user.createdAt}',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: Text(
                'Verified Info',
                style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
              ),
            ),
            UserInfo(
              name: user.username,
              email: user.email,
              phoneNumber: '+251951479135',
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: Text(
                'Account Settings',
                style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
              ),
            ),
            ExpansionBar(
                title: 'Change Password',
                children: Container(
                  padding: EdgeInsets.only(left: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Textfields(
                          subtitles: 'Enter Old Password',
                          controller: oldPasswordController),
                      Textfields(
                          subtitles: 'Enter New Password',
                          controller: newPasswordController),
                    ],
                  ),
                ),
                childOfButton1: 'Save Changes',
                childOfButton2: 'Cancel',
                buttonBackgroundColor: Color.fromARGB(255, 255, 115, 0),
                save: () {
                  final oldPassword = oldPasswordController.text;
                  final newPassword = newPasswordController.text;
                  BlocProvider.of<UserBloc>(context).add(
                    UpdatePassword(
                      oldPassword: oldPassword,
                      newPassword: newPassword,
                    ),
                  );
                },
                cancel: () {
                  print('cancel clicked');
                  ;
                }),
            Container(
              child: ExpansionBar(
                  title: 'Delete Account',
                  titleColor: Colors.red,
                  children: Row(
                    children: [
                      SizedBox(
                        width: 15,
                      ),
                      Expanded(
                          child: Text(
                              'Are you sure you want to delete your account?')),
                    ],
                  ),
                  childOfButton1: 'Confirm',
                  childOfButton2: 'Cancel',
                  buttonBackgroundColor: Colors.red,
                  save: () {
                    BlocProvider.of<UserBloc>(context).add(
                      DeleteAccount(),
                    );
                    ;
                  },
                  cancel: () {
                    print('cancel clicked');
                    ;
                  }),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [LogOut()],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
