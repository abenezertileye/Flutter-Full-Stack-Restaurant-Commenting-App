import 'package:flutter/material.dart';
import 'package:restaurant_review/presentation/widgets/my_button.dart';

class DialogBox extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onCancel;
  final Function(String) onSave; // Updated to accept a String argument

  DialogBox({
    Key? key, // Use 'key' instead of 'super.key'
    required this.onCancel,
    required this.onSave,
    required this.controller,
  }) : super(key: key); // Correct usage of the key parameter

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Color.fromRGBO(235, 125, 56, 1),
      content: Container(
        height: 150,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: "Write a review",
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.amber),
                ),
              ),
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MyDialogButton(
                  text: "Save",
                  onPressed: () {
                    print('save clicked');
                    onSave(controller.text);
                  },
                ),
                SizedBox(width: 8),
                MyDialogButton(
                  text: "Cancel",
                  onPressed: onCancel,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
