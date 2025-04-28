import 'package:flutter/material.dart';

class ExerciseListScreen extends StatelessWidget {
  final String muscle;
  const ExerciseListScreen({super.key, required this.muscle});

  @override
  Widget build(BuildContext context) {
    final Map<String, List<String>> exercises = {
      'Chest': ['Bench Press', 'Incline Dumbbell Press', 'Push Ups'],
      'Bicep': ['Bicep Curls', 'Hammer Curls', 'Concentration Curls'],
    };

    final List<String> exerciseList = exercises[muscle] ?? [];

    return Scaffold(
      appBar: AppBar(
        title: Text('$muscle Exercises'),
      ),
      body: ListView.builder(
        itemCount: exerciseList.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              title: Text(
                exerciseList[index],
                style: const TextStyle(fontSize: 18),
              ),
            ),
          );
        },
      ),
    );
  }
}
