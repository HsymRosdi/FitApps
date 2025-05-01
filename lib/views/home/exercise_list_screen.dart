import 'package:flutter/material.dart';

class ExerciseInstructionScreen extends StatelessWidget {
  final String title;
  final List<String> steps;

  const ExerciseInstructionScreen({
    super.key,
    required this.title,
    required this.steps,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView.builder(
          itemCount: steps.length,
          itemBuilder: (context, index) => ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.blue,
              child: Text('${index + 1}', style: const TextStyle(color: Colors.white)),
            ),
            title: Text(steps[index]),
          ),
        ),
      ),
    );
  }
}

// Main list screen
class ExerciseListScreen extends StatelessWidget {
  final String muscle;
  const ExerciseListScreen({super.key, required this.muscle});

  @override
  Widget build(BuildContext context) {
    final Map<String, List<Map<String, dynamic>>> exercises = {
      'Chest': [
        {
          'name': 'Bench Press',
          'steps': [
            "Lie on a flat bench with your feet flat on the floor.",
            "Grip the bar slightly wider than shoulder-width.",
            "Lower the bar slowly to your chest.",
            "Press the bar back up to starting position.",
          ]
        },
        {
          'name': 'Incline Dumbbell Press',
          'steps': [
            "Sit on an incline bench with a dumbbell in each hand.",
            "Press the dumbbells above your chest.",
            "Lower them slowly to shoulder level.",
            "Repeat."
          ]
        },
        {
          'name': 'Push Ups',
          'steps': [
            "Start in a plank position with hands shoulder-width apart.",
            "Lower your body until chest almost touches the floor.",
            "Push back up to plank position.",
          ]
        },
      ],
      'Bicep': [
        {
          'name': 'Bicep Curls',
          'steps': [
            "Stand straight holding dumbbells in both hands.",
            "Curl the dumbbells toward your shoulders.",
            "Lower them back down slowly.",
            "Keep elbows tucked to your side."
          ]
        },
        {
          'name': 'Hammer Curls',
          'steps': [
            "Hold dumbbells with palms facing your body.",
            "Curl the weights up while keeping palms facing inward.",
            "Lower slowly.",
          ]
        },
        {
          'name': 'Concentration Curls',
          'steps': [
            "Sit on a bench and lean forward slightly.",
            "Hold a dumbbell with one hand and rest elbow on your thigh.",
            "Curl the dumbbell upward, then lower slowly.",
          ]
        },
      ],
      'Leg': [
        {
          'name': 'Split Squat',
          'steps': [
            "Place one foot forward and one behind.",
            "Lower your body by bending both knees.",
            "Push through the front heel to return to start.",
          ]
        },
        {
          'name': 'Back Squat',
          'steps': [
            "Place a barbell on your upper back.",
            "Squat down until your thighs are parallel to the floor.",
            "Push back up to starting position.",
          ]
        },
        {
          'name': 'Deadlift',
          'steps': [
            "Stand with feet hip-width apart and barbell over midfoot.",
            "Bend hips and grip the bar.",
            "Lift the bar by straightening your body.",
            "Lower back down with control."
          ]
        },
      ],
      'Tricep': [
        {
          'name': 'Tricep Pushdown',
          'steps': [
            "Stand at a cable machine with a bar or rope attachment.",
            "Keep elbows close to your body and push the bar down.",
            "Slowly return to starting position."
          ]
        },
        {
          'name': 'Bench Dip',
          'steps': [
            "Sit on a bench with hands at your sides.",
            "Move forward off the bench and lower your body.",
            "Push back up using your triceps."
          ]
        },
        {
          'name': 'Tricep Dips',
          'steps': [
            "Position yourself between dip bars.",
            "Lower your body until elbows are at 90 degrees.",
            "Push back up to starting position."
          ]
        },
      ]
    };

    final List<Map<String, dynamic>> exerciseList = exercises[muscle] ?? [];

    return Scaffold(
      appBar: AppBar(
        title: Text('$muscle Exercises'),
      ),
      body: ListView.builder(
        itemCount: exerciseList.length,
        itemBuilder: (context, index) {
          final exercise = exerciseList[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              title: Text(
                exercise['name'],
                style: const TextStyle(fontSize: 18),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ExerciseInstructionScreen(
                      title: exercise['name'],
                      steps: List<String>.from(exercise['steps']),
                    ),
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
