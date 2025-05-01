import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fitapps/views/home/workout_screen.dart';

void main() {
  testWidgets('WorkoutPage shows all workout categories', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: WorkoutPage(),
      ),
    );

    expect(find.text('Chest'), findsOneWidget);
    expect(find.text('Bicep'), findsOneWidget);
    expect(find.text('Leg'), findsOneWidget);
    expect(find.text('Tricep'), findsOneWidget);
  });
}
