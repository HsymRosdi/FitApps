import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitapps/views/camera/camera_screen.dart';
import 'package:fitapps/views/home/gym_screen.dart';
import 'package:fitapps/views/notifications/notification_screen.dart';
import 'package:flutter/material.dart';
import 'package:fitapps/views/home/workout_screen.dart';
import 'package:fitapps/views/home/profile_screen.dart';
import 'package:fitapps/widgets/bottom_navbar.dart';
import 'package:fitapps/views/auth/login_screen.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart'; // ✅ add this

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  String lastName = '';
  bool isLoading = true;

  final List<String> quotes = [
    "Push yourself, because no one else will do it for you.",
    "You don't have to be great to start, but you have to start to be great.",
    "No pain, no gain. Shut up and train.",
  ];

  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _loadUserData();

    // ✅ Initialize YouTube player controller
    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId('https://www.youtube.com/watch?v=2i2khp_npdE')!, // 🎵 your motivational video
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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

  final List<Widget> _pages = [
    Placeholder(), // still your normal pages
    const WorkoutPage(),
    const ProfilePage(),
    const GymPage(),
    const NotificationPage(),
    const CameraPage(),
  ];

  Future<void> _logout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
      (route) => false,
    );
  }

  Widget buildHomePage() {
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),
                Text(
                  "Hi, $lastName 👋",
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 120,
                  child: PageView.builder(
                    itemCount: quotes.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Text(
                                quotes[index],
                                style: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 30),
                // 🎵 Add Gym Song Player here
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      const Text(
                        "🎵 Gym Workout Song 🎵",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      YoutubePlayer(
                        controller: _controller,
                        showVideoProgressIndicator: true,
                        width: double.infinity,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
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
                color: Color(0xFF2F80ED),
              ),
              child: Text(
                'Menu',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.notifications),
              title: const Text('Notifications'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const NotificationPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera),
              title: const Text('Progress'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const CameraPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: _logout,
            ),
          ],
        ),
      ),
      body: _currentIndex == 0 ? buildHomePage() : _pages[_currentIndex],
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
      ),
    );
  }
}
