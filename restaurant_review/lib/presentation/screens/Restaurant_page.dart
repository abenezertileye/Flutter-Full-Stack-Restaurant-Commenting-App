import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_review/presentation/widgets/dialog_box.dart';
import 'package:restaurant_review/presentation/widgets/popUp.dart';
import 'package:restaurant_review/infrastructure/repository/restaurant_page_repository.dart';
import 'package:restaurant_review/domain/usecase/restaurant_page_usecase.dart';
import 'package:restaurant_review/application/bloc/restaurant_page_bloc/restaurant_page_event.dart';
import 'package:restaurant_review/application/bloc/restaurant_page_bloc/restaurant_page_bloc.dart';
import 'package:restaurant_review/application/bloc/restaurant_page_bloc/restaurant_page_state.dart';
import '../widgets/list_tile.dart';
import '../widgets/comments.dart';
import '../widgets/user_tile.dart';

class RestaurantPage extends StatelessWidget {
  final String restaurantId;

  RestaurantPage({this.restaurantId = 'None'});

  void cancelTask(BuildContext context) {
    Navigator.of(context).pop();
  }

  void createNewComment(BuildContext context) {
    final TextEditingController _controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _controller,
          onCancel: () => cancelTask(context),
          onSave: (opinion) {
            BlocProvider.of<RestaurantPageBloc>(context).add(
              CreateCommentButtonPressed(opinion: opinion),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final restaurantPageRepository = RestaurantPageRepository();
    final restaurantPageUseCase = RestaurantPageUseCase(
        restaurantPageRepository: restaurantPageRepository);

    return BlocProvider(
        create: (context) => RestaurantPageBloc(
            restaurantId: restaurantId,
            restaurantPageUseCase: restaurantPageUseCase)
          ..add(FetchRestaurantDetails(restaurantId)),
        child: Scaffold(
          body: BlocBuilder<RestaurantPageBloc, RestaurantPageState>(
            builder: (context, state) {
              if (state is RestaurantPageLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (state is RestaurantPageLoaded) {
                final restaurant = state.restaurant;
                print(
                    'restaurant data in restaurant profile page: $restaurant');
                print(
                    'comment in restaurant profile page: ${restaurant.comments}');
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
                                          restaurant.name,
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
                                      '(${restaurant.comments.length})',
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
                                          title: restaurant.location,
                                          leading: Icon(Icons.location_on,
                                              size: 17, color: Colors.orange),
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        list_tile(
                                          title:
                                              'Mon - Fri | ${restaurant.openingTime} - ${restaurant.closingTime}',
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
                              Text(restaurant.description),
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
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: restaurant.comments.map((comment) {
                                  final TextEditingController _controller =
                                      TextEditingController();
                                  return Comment(
                                    user_info: UserTile(
                                        username: comment.username,
                                        date: 'Nov 1, 2023',
                                        image: '',
                                        onDeletePressed: () {
                                          BlocProvider.of<RestaurantPageBloc>(
                                                  context)
                                              .add(
                                            DeleteCommentButtonPressed(
                                              commentId: comment.id,
                                            ),
                                          );
                                        },
                                        onUpdatePressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return DialogBox(
                                                controller: _controller,
                                                onCancel: () =>
                                                    cancelTask(context),
                                                onSave: (opinion) {
                                                  BlocProvider.of<
                                                              RestaurantPageBloc>(
                                                          context)
                                                      .add(
                                                    UpdateCommentButtonPressed(
                                                        commentId: comment.id,
                                                        opinion: opinion),
                                                  );
                                                },
                                              );
                                            },
                                          );
                                        }),
                                    comment: comment.opinion,
                                  );
                                }).toList(),
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
              } else if (state is DeleteCommentError) {
                return PopUp(
                  message: state.error,
                );
              } else if (state is DeleteCommentLoaded) {
                return PopUp(
                  message: state.confirmation,
                );
              } else {
                return Center(child: Text("No data"));
              }
            },
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => createNewComment(context),
            shape: const CircleBorder(),
            child: Container(
              width: 60,
              height: 60,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    Color.fromARGB(255, 255, 189, 74),
                    Color.fromARGB(255, 248, 157, 72),
                  ],
                ),
              ),
              child: const Icon(
                Icons.add,
                size: 40,
              ),
            ),
          ),
        ));
  }
}
