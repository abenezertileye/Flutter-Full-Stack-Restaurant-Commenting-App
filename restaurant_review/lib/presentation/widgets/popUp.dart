import 'package:flutter/material.dart';
import 'package:restaurant_review/presentation/widgets/my_button.dart';

class Popup extends StatelessWidget {
  final String message;

  Popup({
    Key? key, // Use 'key' instead of 'super.key'
    required this.message,
  }) : super(key: key); // Correct usage of the key parameter

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Color.fromRGBO(235, 125, 56, 1),
      content: Container(
        height: 150,
        child: Text(message),
      ),
    );
  }
}
