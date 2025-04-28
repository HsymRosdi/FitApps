import 'package:flutter/material.dart';
import 'package:fitapps/views/home/exercise_list_screen.dart';

class WorkoutPage extends StatelessWidget {
  const WorkoutPage({super.key});

  final List<String> muscles = const [
    'Chest',
    'Bicep',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: muscles.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              leading: const Icon(Icons.fitness_center, color: Color(0xFF2F80ED)),
              title: Text(
                muscles[index],
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ExerciseListScreen(muscle: muscles[index]),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
