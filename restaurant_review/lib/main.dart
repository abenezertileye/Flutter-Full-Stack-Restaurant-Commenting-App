import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
import 'package:restaurant_review/presentation/screens/search_page.dart';
import 'package:restaurant_review/presentation/screens/sign_up_page.dart';
import 'package:restaurant_review/infrastructure/repository/restaurant_crud_repository.dart';

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

    final restaurantCrudUsecase = RestaurantCrudUsecase(restaurantCrudRepository);
    return MultiBlocProvider(
      providers: [
        BlocProvider<RestaurantPageBloc>(
          create: (context) => RestaurantPageBloc(
            restaurantId: 'None',
            restaurantPageUseCase: restaurantPageUseCase,
          ),
        ),

        BlocProvider<RestaurantCrudBloc>(create: (context) => RestaurantCrudBloc(restaurantCrudUsecase),)

        
        // Add other providers here if needed
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.LightThemeMode,
        home: SignUpPage(),
        routes: {
          '/firstpage': (context) => ReviewHome(),
          '/searchpage': (context) => SearchPage(),
          '/profilepage': (context) => ProfilePage(),
          "/restaurantpage": (context) => RestaurantPage(),
          '/adminprofile': (context) => AdminTab(),
          "/entry": (context) => BottomNav()
        },
      ),
    );
  }
}
