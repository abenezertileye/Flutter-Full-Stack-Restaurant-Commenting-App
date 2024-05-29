import 'package:flutter/material.dart';

class PopUp extends StatelessWidget {
  final String message;

  const PopUp({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Color.fromRGBO(235, 125, 56, 1),
      content: Container(
        height: 150,
        child: Center(
          child: Text(
            message,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
