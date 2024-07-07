import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_widget/main.dart'; // Zaimportuj swój plik main.dart

void main() {
  testWidgets('Weather Widget displays city name', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

    // Verify that the city name is displayed.
    expect(find.text('Bytów'), findsOneWidget); // Zakładamy, że początkowe miasto to 'Bytów'
  });
}
