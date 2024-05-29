import 'package:flutter/material.dart';

class Buttons extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final VoidCallback onpressed;

  Buttons({
    required this.text,
    required this.backgroundColor,
    required this.onpressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      // width: 100,
      // constraints: BoxConstraints(
      //   maxWidth:
      // ),
      child: ElevatedButton(
          onPressed: onpressed,
          child: Text(
            text,
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(backgroundColor),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          )),
    );
  }
}
