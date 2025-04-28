import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class GymPage extends StatefulWidget {
  const GymPage({super.key});

  @override
  State<GymPage> createState() => _GymPageState();
}

class _GymPageState extends State<GymPage> {
  String locationMessage = 'Tap the button to find nearby gyms!';
  bool isLoading = false; // 🔥 New variable to track loading

  Future<void> _askPermissionAgain() async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Location Permission'),
        content: const Text('This app needs your location to find nearby gyms. Allow access?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close popup
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context); // Close popup
              await _getCurrentLocation(); // Continue to get location
            },
            child: const Text('Allow'),
          ),
        ],
      ),
    );
  }

  Future<void> _getCurrentLocation() async {
    setState(() {
      isLoading = true; // 🔥 Start loading
    });

    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        locationMessage = 'Location services are disabled.';
        isLoading = false;
      });
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        setState(() {
          locationMessage = 'Location permission not granted.';
          isLoading = false;
        });
        return;
      }
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    setState(() {
      locationMessage =
          'Nearby gyms around: ${position.latitude}, ${position.longitude}';
      isLoading = false; // 🔥 Stop loading
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nearby Gyms')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (isLoading)
                const CircularProgressIndicator() // 🔥 Show spinner
              else
                Text(
                  locationMessage,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 18),
                ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _askPermissionAgain,
                child: const Text('Find Nearby Gym'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
