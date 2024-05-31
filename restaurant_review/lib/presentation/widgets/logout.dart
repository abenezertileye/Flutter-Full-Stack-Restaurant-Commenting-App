// Inside the LogOut widget

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:restaurant_review/infrastructure/repository/admin_repository.dart';
import 'package:restaurant_review/presentation/screens/login_in_page.dart';

class LogOut extends StatelessWidget {
  final AdminRepository authService = AdminRepository();


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Call the logout method
        authService.logout();
        // Navigate back to the login page
        context.go('/login');
      },
      child: Center(
        child: Row(
          children: [
            Icon(Icons.logout),
            SizedBox(
              width: 10,
            ),
            Text(
              'Log Out',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
