import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:integration_test/integration_test.dart';
import 'package:restaurant_review/main.dart' as app;
import 'package:restaurant_review/presentation/screens/bottom_nav.dart';
import 'package:restaurant_review/presentation/screens/sign_up_page.dart';
import 'package:restaurant_review/presentation/screens/login_in_page.dart';
import 'package:flutter/material.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Authentication Tests', () {
    testWidgets('Sign Up Test', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Navigate to Sign Up page
      expect(find.byType(SignUpPage), findsOneWidget);

      // Enter Sign Up details
      await tester.enterText(
          find.byKey(Key('usernameSignUpField')), 'user13020');
      await tester.enterText(
          find.byKey(Key('emailSignUpField')), 'user10032@example.com');
      await tester.enterText(
          find.byKey(Key('passwordSignUpField')), 'password');
      await tester
          .tap(find.byKey(Key('userTypeRadioButtonUser'))); // Select user type
      await tester.tap(find.byKey(Key('signUpButton')));

      // Wait for the sign up process to complete
      await tester.pumpAndSettle();

      GoRoute(
        name: 'home',
        path: '/home',
        builder: (context, state) => BottomNav(),
      );
      // Check if navigated to Log In page
      // expect(find.byType(LogInPage), findsOneWidget);
    });

    testWidgets('Log In Test', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Navigate to Log In page
      expect(find.byType(LogInPage), findsOneWidget);

      // Enter Log In details
      await tester.enterText(find.byKey(Key('usernameLoginField')), 'user132');
      await tester.enterText(find.byKey(Key('passwordLoginField')), 'password');
      await tester.tap(find.byKey(Key('loginButton')));

      // Wait for the log in process to complete
      await tester.pumpAndSettle();

      await Future.delayed(Duration(seconds: 3));
      // Check if navigated to Home page
      expect(find.text('Restaurant Review'), findsOneWidget);
    });
  });
}
