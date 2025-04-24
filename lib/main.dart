import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();

  if(kIsWeb){
    await Firebase.initializeApp(options: FirebaseOptions(apiKey: "AIzaSyAvCzOeqEP8Xxq2YYK6ghdsuWIuC6aRVQM",
  authDomain: "fitapps-15ba5.firebaseapp.com",
  projectId: "fitapps-15ba5",
  storageBucket: "fitapps-15ba5.firebasestorage.app",
  messagingSenderId: "1095193312133",
  appId: "1:1095193312133:web:6f85291409287b54afe2ec",
  measurementId: "G-38K7T343WH"));
  runApp(const MyApp());
  }else{
    await Firebase.initializeApp();
  }

  
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
    );
}

}
