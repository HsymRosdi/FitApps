import 'package:flutter/material.dart';
import 'package:fitapps/views/home/exercise_list_screen.dart';

class WorkoutPage extends StatefulWidget {
  const WorkoutPage({super.key});

  @override
  State<WorkoutPage> createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> {
  final List<String> muscles = ['Chest', 'Bicep', 'Tricep'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Workouts")),
      body: ListView.builder(
        itemCount: muscles.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Tapped on ${muscles[index]}'),
                  duration: const Duration(milliseconds: 800),
                ),
              );
            },
            onDoubleTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Double tapped ${muscles[index]} 💪'),
                  duration: const Duration(milliseconds: 800),
                ),
              );
            },
            child: Card(
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
            ),
          );
        },
      ),
    );
  }
}
