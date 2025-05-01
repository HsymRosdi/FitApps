import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _oldPassController = TextEditingController();
  final _newPassController = TextEditingController();
  final _confirmPassController = TextEditingController();

  String _statusMessage = '';

  @override
  void initState() {
    super.initState();
    final user = _auth.currentUser;
    if (user != null) {
      _emailController.text = user.email ?? '';
    }
  }

  Future<void> _updateEmail() async {
    try {
      await _auth.currentUser!.updateEmail(_emailController.text.trim());
      setState(() => _statusMessage = '✅ Email updated successfully');
    } catch (e) {
      setState(() => _statusMessage = '❌ Failed to update email: $e');
    }
  }

  Future<void> _updatePassword() async {
    final oldPassword = _oldPassController.text.trim();
    final newPassword = _newPassController.text.trim();
    final confirmPassword = _confirmPassController.text.trim();
    final user = _auth.currentUser;

    if (oldPassword.isEmpty || newPassword.isEmpty || confirmPassword.isEmpty) {
      setState(() => _statusMessage = '❌ All password fields are required');
      return;
    }

    if (newPassword != confirmPassword) {
      setState(() => _statusMessage = '❌ New passwords do not match');
      return;
    }

    if (newPassword.length < 6) {
      setState(() => _statusMessage = '❌ Password must be at least 6 characters');
      return;
    }

    try {
      final credential = EmailAuthProvider.credential(
        email: user!.email!,
        password: oldPassword,
      );
      await user.reauthenticateWithCredential(credential);
      await user.updatePassword(newPassword);

      setState(() => _statusMessage = '✅ Password updated successfully');

      _oldPassController.clear();
      _newPassController.clear();
      _confirmPassController.clear();
    } catch (e) {
      setState(() => _statusMessage = '❌ Failed: $e');
    }
  }

  Widget _buildSectionTitle(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: Colors.blue),
        const SizedBox(width: 8),
        Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          
          Positioned.fill(
            child: Image.asset(
              'assets/gym.jpg',
              fit: BoxFit.cover,
            ),
          ),
          
          SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const Icon(Icons.account_circle, size: 80, color: Colors.white),
                const SizedBox(height: 10),
                const Text(
                  "Manage your account",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white),
                ),
                const SizedBox(height: 30),

               
                Card(
                  elevation: 4,
                  margin: const EdgeInsets.only(bottom: 30),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSectionTitle("Update Email", Icons.email),
                        const SizedBox(height: 12),
                        TextFormField(
                          controller: _emailController,
                          decoration: const InputDecoration(labelText: "Email"),
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _updateEmail,
                            child: const Text("Update Email"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSectionTitle("Change Password", Icons.lock),
                        const SizedBox(height: 12),
                        TextFormField(
                          controller: _oldPassController,
                          obscureText: true,
                          decoration: const InputDecoration(labelText: "Current Password"),
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          controller: _newPassController,
                          obscureText: true,
                          decoration: const InputDecoration(labelText: "New Password"),
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          controller: _confirmPassController,
                          obscureText: true,
                          decoration: const InputDecoration(labelText: "Confirm New Password"),
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _updatePassword,
                            child: const Text("Update Password"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                if (_statusMessage.isNotEmpty)
                  Text(
                    _statusMessage,
                    style: TextStyle(
                      color: _statusMessage.contains('✅') ? Colors.green : Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
