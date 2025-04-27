import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitapps/core/models/user_model.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> saveUserData(UserModel user) async {
    await _firestore.collection('users').doc(user.userId).set(user.toMap());
  }
}
