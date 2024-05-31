import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_review/presentation/widgets/modal_form_text_field.dart'; // Adjust the import path as needed

void main() {
  testWidgets('TextFieldWLabel displays label and asterisk for required fields',
      (WidgetTester tester) async {
    // Create a TextEditingController for the test
    final TextEditingController controller = TextEditingController();

    // Build the TextFieldWLabel widget
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: TextFieldWLabel(
            label: 'Test Label',
            required: true,
            controller: controller,
          ),
        ),
      ),
    );

    // Find the label text and asterisk
    final labelFinder = find.text('Test Label');
    final asteriskFinder = find.text('*');

    // Verify that the label and asterisk are displayed
    expect(labelFinder, findsOneWidget);
    expect(asteriskFinder, findsOneWidget);

    // Verify the TextFormField is present
    expect(find.byType(TextFormField), findsOneWidget);
  });

  testWidgets(
      'TextFieldWLabel does not display asterisk for non-required fields',
      (WidgetTester tester) async {
    // Create a TextEditingController for the test
    final TextEditingController controller = TextEditingController();

    // Build the TextFieldWLabel widget
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: TextFieldWLabel(
            label: 'Test Label',
            required: false,
            controller: controller,
          ),
        ),
      ),
    );

    // Find the label text and asterisk
    final labelFinder = find.text('Test Label');
    final asteriskFinder = find.text('*');

    // Verify that the label is displayed and the asterisk is not displayed
    expect(labelFinder, findsOneWidget);
    expect(asteriskFinder, findsNothing);

    // Verify the TextFormField is present
    expect(find.byType(TextFormField), findsOneWidget);
  });

  testWidgets('TextFieldWLabel shows validation error for required fields',
      (WidgetTester tester) async {
    // Create a TextEditingController for the test
    final TextEditingController controller = TextEditingController();

    // Build the TextFieldWLabel widget
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Form(
            key: GlobalKey<FormState>(), // Use a GlobalKey to get the FormState
            child: TextFieldWLabel(
              label: 'Test Label',
              required: true,
              controller: controller,
            ),
          ),
        ),
      ),
    );

    // Attempt to submit the form to trigger validation
    final form = tester.state(find.byType(Form)) as FormState;
    form.validate();
    await tester.pump();

    // Find the validation error text
    final errorFinder = find.text('This field is required');

    // Verify that the validation error is displayed
    expect(errorFinder, findsOneWidget);
  });
}
