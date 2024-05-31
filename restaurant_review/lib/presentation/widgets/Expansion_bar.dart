import 'package:flutter/material.dart';
import 'buttons.dart';

class ExpansionBar extends StatelessWidget {
  final String title;
  final Color titleColor;
  final Widget children;
  final String childOfButton1;
  final String childOfButton2;
  final Color buttonBackgroundColor;
  final VoidCallback? onButton1Pressed;
  final VoidCallback? onButton2Pressed;

  ExpansionBar({
    required this.title,
    required this.children,
    this.titleColor = Colors.black,
    required this.childOfButton1,
    required this.childOfButton2,
    required this.buttonBackgroundColor,
    this.onButton1Pressed,
    this.onButton2Pressed,
  });

  
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 30),
        padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(8),
        ),
        child: ExpansionTile(
          backgroundColor: Colors.grey[300],
          title: Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, color: titleColor),
          ),
          children: [
            children,
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Buttons(
                  text: childOfButton1,
                  backgroundColor: buttonBackgroundColor,
                  onPressed: onButton1Pressed,
                ),
                Buttons(
                  text: childOfButton2,
                  backgroundColor: Colors.grey,
                  onPressed: onButton2Pressed,
                ),
              ],
            ),
            SizedBox(
              height: 20,
            )
          ],
        ));
  }
}
