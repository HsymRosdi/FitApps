import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fitapps/views/home/exercise_list_screen.dart';

void main() {
  testWidgets('ExerciseListScreen shows chest exercises', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: ExerciseListScreen(muscle: 'Chest'),
    ));

    // Check the AppBar title
    expect(find.text('Chest Exercises'), findsOneWidget);

    // Check the exercises for Chest
    expect(find.text('Bench Press'), findsOneWidget);
    expect(find.text('Incline Dumbbell Press'), findsOneWidget);
    expect(find.text('Push Ups'), findsOneWidget);
  });

  testWidgets('ExerciseListScreen shows bicep exercises', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: ExerciseListScreen(muscle: 'Bicep'),
    ));

    expect(find.text('Bicep Curls'), findsOneWidget);
    expect(find.text('Hammer Curls'), findsOneWidget);
    expect(find.text('Concentration Curls'), findsOneWidget);
  });
}
