import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'views/auth/login_screen.dart'; // <- Make sure this exists

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyAvCzOeqEP8Xxq2YYK6ghdsuWIuC6aRVQM",
        authDomain: "fitapps-15ba5.firebaseapp.com",
        projectId: "fitapps-15ba5",
        storageBucket: "fitapps-15ba5.appspot.com", // typo fixed here
        messagingSenderId: "1095193312133",
        appId: "1:1095193312133:web:6f85291409287b54afe2ec",
        measurementId: "G-38K7T343WH",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FitApps',
      debugShowCheckedModeBanner: false,
      home: const LoginScreen(), // <-- Make sure this screen exists
    );
  }
}
