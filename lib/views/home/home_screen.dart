import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitapps/views/home/gym_screen.dart';
import 'package:flutter/material.dart';
import 'package:fitapps/views/home/workout_screen.dart';
import 'package:fitapps/views/home/profile_screen.dart';
import 'package:fitapps/widgets/bottom_navbar.dart';
import 'package:fitapps/views/auth/login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  String lastName = '';
  bool isLoading = true;

  final List<Widget> _pages = [
    Center(child: Text('🏠 Home Page', style: TextStyle(fontSize: 24))),
    const WorkoutPage(),
    const ProfilePage(),
    const GymPage(),
  ];

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final doc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
        if (doc.exists && mounted) {
          setState(() {
            lastName = doc.data()?['lastName'] ?? '';
            isLoading = false;
          });
        }
      }
    } catch (e) {
      print('❌ Error fetching user data: $e');
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

 
Future<void> _logout() async {
  await FirebaseAuth.instance.signOut();
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => const LoginScreen()),
    (route) => false,
  );
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: isLoading
            ? const Text("Loading...")
            : Text("Hi, $lastName 👋"),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {
                Navigator.pop(context); // close the drawer first
                _logout(); // then logout
              },
            ),
          ],
        ),
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
      ),
    );
  }
}
