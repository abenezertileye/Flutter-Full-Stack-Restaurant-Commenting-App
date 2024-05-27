import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_review/presentation/widgets/dialog_box.dart';
import 'package:restaurant_review/infrastructure/repository/restaurant_page_repository.dart';
import 'package:restaurant_review/domain/usecase/restaurant_page_usecase.dart';
import 'package:restaurant_review/presentation/bloc/restaurant_page_bloc/restaurant_page_event.dart';
import 'package:restaurant_review/presentation/bloc/restaurant_page_bloc/restaurant_page_bloc.dart';
import 'package:restaurant_review/presentation/bloc/restaurant_page_bloc/restaurant_page_state.dart';
import '../widgets/list_tile.dart';
import '../widgets/comments.dart';
import '../widgets/user_tile.dart';

class RestaurantPage extends StatelessWidget {
  final String username;

  RestaurantPage({this.username = 'None'});

  void cancelTask(BuildContext context) {
    Navigator.of(context).pop();
  }

  void createNewComment(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          onCancel: () => cancelTask(context),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    print('username: $username');

    final restaurantPageRepository = RestaurantPageRepository();
    final restaurantPageUseCase = RestaurantPageUseCase(
        restaurantPageRepository: restaurantPageRepository);

    return BlocProvider(
      create: (context) => RestaurantPageBloc(
          username: username, restaurantPageUseCase: restaurantPageUseCase)
        ..add(FetchRestaurantDetails(username)),
      child: Scaffold(
        body: BlocBuilder<RestaurantPageBloc, RestaurantPageState>(
          builder: (context, state) {
            if (state is RestaurantPageLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is RestaurantPageLoaded) {
              final restaurant = state.restaurant;
              return SizedBox(
                height: 1000,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 200,
                        child: Opacity(
                          opacity: 0.5,
                          child: Image.asset(
                            'assets/pizza.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(bottom: 15),
                              child: Row(
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 40,
                                      ),
                                      Text(
                                        'restaurant.username', // dummy username
                                        style: Theme.of(context)
                                            .textTheme
                                            .displayMedium!
                                            .copyWith(
                                              color: Colors.black,
                                              fontSize: 20,
                                            ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    '(31)', // Dummy data,
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 10),
                              child: Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      list_tile(
                                        title:
                                            'King George VI St, Addis Ababa', // Dummy address
                                        leading: Icon(Icons.location_on,
                                            size: 17, color: Colors.orange),
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      list_tile(
                                        title:
                                            'Mon - Fri | 8:30AM - 10:00PM', // Dummy opening hours
                                        leading: Icon(
                                            Icons.access_time_outlined,
                                            size: 17,
                                            color: Colors.orange),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 50,
                                  ),
                                  Text(
                                    'Open', // Dummy status
                                    style: TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              'Proin eget sollicitudin mauris. Phasellus imperdiet est in lectus imperdiet fringilla. Vivamus ultrices eget ligula sed placerat. Curabitur scelerisque massa eu odio tempor convallis ac porta diam. Donec nisl nunc, lobortis ac nisi vitae, mollis finibus est.', // Dummy description
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 20, top: 5),
                              child: Text(
                                '+ Read More',
                                style: TextStyle(
                                  color: Colors.orange,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  'Reviews',
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayMedium!
                                      .copyWith(
                                        color: Colors.black,
                                        fontSize: 18,
                                      ),
                                ),
                              ],
                            ),
                            Comment(
                              user_info: UserTile(
                                  name: 'Darrow Lykos',
                                  date: 'Nov 1, 2023',
                                  image: ''),
                              comment:
                                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque lobortis lorem a ultrices rhoncus. Nam efficitur sapien et tincidunt laoreet. Nulla non ante lacus. Morbi lorem mauris, posuere et risus ac, accumsan fringilla orci. Curabitur id sem in risus accumsan elementum.',
                            ),
                            Comment(
                              user_info: UserTile(
                                  name: 'Darrow Lykos',
                                  date: 'Nov 1, 2023',
                                  image: ''),
                              comment:
                                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque lobortis lorem a ultrices rhoncus. Nam efficitur sapien et tincidunt laoreet. Nulla non ante lacus. Morbi lorem mauris, posuere et risus ac, accumsan fringilla orci. Curabitur id sem in risus accumsan elementum.',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else if (state is RestaurantPageError) {
              return Center(child: Text(state.message));
            } else {
              return Center(child: Text("No data"));
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => createNewComment(context),
          shape: CircleBorder(),
          child: Container(
            width: 60,
            height: 60,
            child: Icon(
              Icons.add,
              size: 40,
            ),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  Color.fromARGB(255, 255, 189, 74),
                  Color.fromARGB(255, 248, 157, 72),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
