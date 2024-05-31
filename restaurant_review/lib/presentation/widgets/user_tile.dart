import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  final String image;
  final String username;
  final String date;
  final VoidCallback onDeletePressed; // Callback function for delete action
  final VoidCallback onUpdatePressed; // Callback function for delete action

  UserTile({
    required this.username,
    required this.date,
    required this.image,
    required this.onDeletePressed, // Constructor to receive the callback
    required this.onUpdatePressed, // Constructor to receive the callback
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage('assets/images/default_profile.jpg'),
          radius: 20,
        ),
        title: Text(
          username,
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w900),
        ),
        subtitle: Text(
          'Review Date · $date',
          style: TextStyle(fontSize: 12),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: onUpdatePressed, // Call the callback function
              child: Icon(
                Icons.edit,
              ),
            ),
            SizedBox(width: 12),
            GestureDetector(
              onTap: onDeletePressed, // Call the callback function
              child: Icon(
                Icons.delete,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
