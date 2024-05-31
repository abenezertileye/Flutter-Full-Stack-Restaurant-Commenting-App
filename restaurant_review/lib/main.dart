import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:restaurant_review/application/bloc/restaurant_crud_bloc/restaurant_crud_bloc.dart';
import 'package:restaurant_review/application/bloc/restaurant_page_bloc/restaurant_page_bloc.dart';
import 'package:restaurant_review/core/theme/theme.dart';
import 'package:restaurant_review/domain/usecase/restaurant_crud_usecase.dart';
import 'package:restaurant_review/domain/usecase/restaurant_page_usecase.dart';
import 'package:restaurant_review/infrastructure/repository/restaurant_page_repository.dart';
import 'package:restaurant_review/presentation/screens/Profile_page.dart';
import 'package:restaurant_review/presentation/screens/Restaurant_page.dart';
import 'package:restaurant_review/presentation/screens/admin_tab.dart';
import 'package:restaurant_review/presentation/screens/bottom_nav.dart';
import 'package:restaurant_review/presentation/screens/home_page.dart';
import 'package:restaurant_review/presentation/screens/login_in_page.dart';
import 'package:restaurant_review/presentation/screens/search_page.dart';
import 'package:restaurant_review/presentation/screens/sign_up_page.dart';
import 'package:restaurant_review/infrastructure/repository/restaurant_crud_repository.dart';



final _router = GoRouter(
  initialLocation: "/signup",
  routes: [
    GoRoute(
      name: "signup",
      path: '/signup',
      builder: (context, state) => SignUpPage(),
    ),

    GoRoute(
      name: "login",
      path: '/login',
      builder: (context, state) => LogInPage(),
    ),

    GoRoute(
      name: "home",
      path: '/home',
      builder: (context, state) => BottomNav(),
    ),

    GoRoute(
      name: "adminprofile",
      path: "/adminprofile",
      builder: (context , state) => AdminTab()
    ),
    GoRoute(
      name: '/restaurantpage',
      path: '/restaurantpage/:id',
      builder: (context, state) { return RestaurantPage(restaurantId: state.pathParameters["id"] as String);},
    )
  ]
);








void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final restaurantPageRepository = RestaurantPageRepository();
    final restaurantCrudRepository = RestaurantCrudRepository();
    final restaurantPageUseCase = RestaurantPageUseCase(
        restaurantPageRepository: restaurantPageRepository);

    final restaurantCrudUsecase =
        RestaurantCrudUsecase(restaurantCrudRepository);
    return MultiBlocProvider(
      //bloc providers
      providers: [
        BlocProvider<RestaurantPageBloc>(
          create: (context) => RestaurantPageBloc(
            restaurantId: 'None',
            restaurantPageUseCase: restaurantPageUseCase,
          ),
        ),
        BlocProvider<RestaurantCrudBloc>(
          create: (context) => RestaurantCrudBloc(restaurantCrudUsecase),
        )
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.LightThemeMode,
        // home: SignUpPage(),
        // routes: {
        //   '/firstpage': (context) => ReviewHome(),
        //   '/searchpage': (context) => SearchPage(),
        //   '/profilepage': (context) => ProfilePage(),
        //   "/restaurantpage": (context) => RestaurantPage(),
        //   '/adminprofile': (context) => AdminTab(),
        //   "/entry": (context) => BottomNav()
        // },
        routerConfig: _router,
      ),
    );
  }
}
