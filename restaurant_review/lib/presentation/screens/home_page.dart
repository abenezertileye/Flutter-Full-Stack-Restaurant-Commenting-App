import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:restaurant_review/presentation/widgets/restaurant.dart';
// import '/models/restaurant_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/search_widget.dart';
import '/data/restaurant_data.dart';
import 'package:restaurant_review/presentation/bloc/home_page_bloc/restaurants_bloc.dart';
import 'package:restaurant_review/presentation/screens/Restaurant_page.dart';
import 'package:restaurant_review/domain/usecase/restaurants_usecase.dart';
import 'package:restaurant_review/infrastructure/repository/restaurants_repository.dart';
import 'package:restaurant_review/presentation/bloc/home_page_bloc/restaurants_event.dart';
import 'package:restaurant_review/presentation/bloc/home_page_bloc/restaurants_state.dart';
import 'dart:convert';

class ReviewHome extends StatelessWidget {
  const ReviewHome({super.key});

  @override
  Widget build(BuildContext context) {
    final restaurantsRepository = RestaurantsRepository();
    final restaurantsUseCase =
        RestaurantsUseCase(restaurantsRepository: restaurantsRepository);

    return BlocProvider(
      create: (context) =>
          RestaurantBloc(restaurantsUseCase: restaurantsUseCase)
            ..add(FetchRestaurants()),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Restaurant Review",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            const SearchWidget(),
            const SizedBox(
              height: 15,
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(left: 10),
                child: RestaurantGrid(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RestaurantGrid extends StatelessWidget {
  const RestaurantGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RestaurantBloc, RestaurantState>(
      builder: (context, state) {
        if (state is RestaurantLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is RestaurantLoaded) {
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Number of columns in the grid
              crossAxisSpacing: 3, // Spacing between columns
              mainAxisSpacing: 10,
              childAspectRatio: 0.7,
            ),
            itemCount: state.restaurants.length,
            itemBuilder: (context, index) {
              final restaurant = state.restaurants[index];
              // print('restaurants: ');
              // print(restaurant);
              return GestureDetector(
                child: Restaurant(
                  imagePath: DefaultImage.imagePath,
                  restaurantName: restaurant['username'],
                  status: 'open',
                  chipsList: ["Fast Food"],
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          RestaurantPage(username: restaurant['username']),
                    ),
                  );
                  // Navigator.pushNamed(context, '/restaurantpage');
                },
              );
            },
          );
        } else if (state is RestaurantError) {
          return Center(child: Text(state.message));
        } else {
          return Center(child: Text("No data"));
        }
      },
    );
  }
}
