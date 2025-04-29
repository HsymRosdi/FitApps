import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'views/auth/login_screen.dart'; // <-- Your LoginScreen

final FlutterLocalNotificationsPlugin notificationsPlugin = FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyAvCzOeqEP8Xxq2YYK6ghdsuWIuC6aRVQM",
        authDomain: "fitapps-15ba5.firebaseapp.com",
        projectId: "fitapps-15ba5",
        storageBucket: "fitapps-15ba5.appspot.com",
        messagingSenderId: "1095193312133",
        appId: "1:1095193312133:web:6f85291409287b54afe2ec",
        measurementId: "G-38K7T343WH",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }

  // 🔥 Initialize Notifications
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  const InitializationSettings initializationSettings =
      InitializationSettings(android: initializationSettingsAndroid);

  await notificationsPlugin.initialize(initializationSettings);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FitApps',
      debugShowCheckedModeBanner: false,
      home: const LoginScreen(), // <-- Entry point of your app
    );
  }
}
