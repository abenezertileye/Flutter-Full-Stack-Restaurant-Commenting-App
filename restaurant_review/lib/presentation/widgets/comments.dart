import 'package:flutter/material.dart';

class Comment extends StatelessWidget {
  final Widget user_info;
  final String comment;

  Comment({required this.user_info, required this.comment});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          user_info,
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Text(comment),
          ),
        ],
      ),
    );
  }
}
