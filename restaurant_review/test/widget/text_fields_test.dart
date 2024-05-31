import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_review/presentation/widgets/text_fields.dart';

void main() {
  testWidgets('Textfields displays subtitles correctly',
      (WidgetTester tester) async {
    // Define test data
    const String testSubtitles = 'Enter your text';
    final TextEditingController controller =
        TextEditingController(); // Create a controller

    // Build the Textfields widget
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Textfields(
              subtitles: testSubtitles,
              controller: controller), // Pass the controller
        ),
      ),
    );

    // Find elements in the Textfields widget
    final subtitlesFinder = find.text(testSubtitles);

    // Verify the elements are found
    expect(subtitlesFinder, findsOneWidget);
  });

  testWidgets('Textfields has a TextField widget', (WidgetTester tester) async {
    final TextEditingController controller =
        TextEditingController(); // Create a controller

    // Build the Textfields widget
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Textfields(
              subtitles: 'Test Subtitles',
              controller: controller), // Pass the controller
        ),
      ),
    );

    // Find TextField widget
    final textFieldFinder = find.byType(TextField);

    // Verify TextField is found
    expect(textFieldFinder, findsOneWidget);
  });
}
