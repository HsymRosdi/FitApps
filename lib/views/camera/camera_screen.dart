import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:fitapps/services/firebase_services.dart';
import 'package:fitapps/views/home/progress_page.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  final FirebaseService _firebaseService = FirebaseService();
  String? _base64Image;
  String? _date;

  @override
  void initState() {
    super.initState();
    _loadLatestProgressPhoto();
  }

  Future<void> _loadLatestProgressPhoto() async {
    final data = await _firebaseService.getLatestProgressPhoto();
    if (data != null) {
      setState(() {
        _base64Image = data['imageBase64'];
        _date = DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.parse(data['date']));
      });
    }
  }

  Future<void> _takePhoto() async {
    final picker = ImagePicker();
    final XFile? photo = await picker.pickImage(source: ImageSource.camera);

    if (photo == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Camera cancelled')),
      );
      return;
    }

    final File file = File(photo.path);
    final bytes = await file.readAsBytes();
    final base64Image = base64Encode(bytes);

    try {
      await _firebaseService.saveBase64ProgressPhoto(base64Image);
      await _loadLatestProgressPhoto();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Progress photo saved!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('❌ Failed to save photo: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Body Progress')),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _base64Image == null
                  ? const Text("No photo taken yet.")
                  : Column(
                      children: [
                        Image.memory(base64Decode(_base64Image!), height: 250),
                        const SizedBox(height: 10),
                        if (_date != null)
                          Text('Taken on $_date', style: const TextStyle(color: Colors.grey)),
                      ],
                    ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _takePhoto,
                child: const Text("Take Body Progress Photo"),
              ),
              ElevatedButton(
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const ProgressPage()),
    );
  },
  child: const Text("View Progress History"),
),

            ],
          ),
        ),
      ),
      
    );
  }
}
