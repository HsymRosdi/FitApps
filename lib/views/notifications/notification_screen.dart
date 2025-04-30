// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// // Make sure you already have this global in your main.dart
// final FlutterLocalNotificationsPlugin notificationsPlugin = FlutterLocalNotificationsPlugin();

// class NotificationPage extends StatelessWidget {
//   const NotificationPage({super.key});

//   Future<void> showSimpleNotification() async {
//     const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
//       'workout_channel', 
//       'Workout Notifications',
//       importance: Importance.max,
//       priority: Priority.high,
//     );

//     const NotificationDetails platformDetails = NotificationDetails(android: androidDetails);

//     await notificationsPlugin.show(
//       0,
//       '🏋️ Workout Time!',
//       'Stay strong! Time for your daily training! 💪',
//       platformDetails,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Notifications')),
//       body: Center(
//         child: Card(
//           margin: const EdgeInsets.all(24),
//           elevation: 8,
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//           child: Padding(
//             padding: const EdgeInsets.all(24),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 const Text(
//                   'Need a reminder to workout?',
//                   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                 ),
//                 const SizedBox(height: 20),
//                 ElevatedButton(
//                   onPressed: showSimpleNotification,
//                   child: const Text('Remind Me to Workout'),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
