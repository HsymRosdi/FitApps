import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitapps/views/camera/camera_screen.dart';
import 'package:fitapps/views/home/gym_screen.dart';
import 'package:flutter/material.dart';
import 'package:fitapps/views/home/workout_screen.dart';
import 'package:fitapps/views/home/profile_screen.dart';
import 'package:fitapps/widgets/bottom_navbar.dart';
import 'package:fitapps/views/auth/login_screen.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

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

    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId('https://www.youtube.com/watch?v=2i2khp_npdE')!,
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
    Placeholder(),
    const WorkoutPage(),
    const ProfilePage(),
    const GymPage(),
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
      : Stack(
          children: [
            
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/gym.jpg"), // 👈 Your image path
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // 🟦 Semi-transparent overlay for contrast
            Container(
              color: Colors.black.withOpacity(0.6),
            ),

            // 📝 Main content
            SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      "Hi, $lastName 👋",
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),

                  const Text(
                    "💬 Daily Motivation",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 12),

                  SizedBox(
                    height: 140,
                    child: PageView.builder(
                      itemCount: quotes.length,
                      controller: PageController(viewportFraction: 0.9),
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)),
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          color: Colors.white.withOpacity(0.9),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Text(
                                quotes[index],
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontStyle: FontStyle.italic,
                                  color: Colors.black87,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 40),

                  const Text(
                    "🎵 Workout Song of the Day",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 12),

                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: YoutubePlayer(
                      controller: _controller,
                      showVideoProgressIndicator: true,
                      width: double.infinity,
                      progressIndicatorColor: Colors.blueAccent,
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: const Color.fromARGB(255, 56, 61, 65),
      ),
      drawer: Drawer(
        backgroundColor: const Color.fromARGB(255, 190, 192, 196),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 87, 93, 100),
              ),
              child: Text(
                'Menu',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
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
