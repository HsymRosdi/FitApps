import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitapps/core/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Save user profile
  Future<void> saveUserData(UserModel user) async {
    await _firestore.collection('users').doc(user.userId).set(user.toMap());
  }

  // Save progress photo as base64
  Future<void> saveBase64ProgressPhoto(String base64Image) async {
    final user = _auth.currentUser;
    if (user == null) throw Exception('User not logged in');

    await _firestore.collection('body_progress').add({
      'userId': user.uid,
      'imageBase64': base64Image,
      'date': DateTime.now().toIso8601String(),
    });
  }

  // Get latest progress photo
  Future<Map<String, dynamic>?> getLatestProgressPhoto() async {
    final user = _auth.currentUser;
    if (user == null) return null;

    final snapshot = await _firestore
        .collection('body_progress')
        .where('userId', isEqualTo: user.uid)
        .orderBy('date', descending: true)
        .limit(1)
        .get();

    if (snapshot.docs.isNotEmpty) {
      return snapshot.docs.first.data();
    }

    return null;
  }
}
