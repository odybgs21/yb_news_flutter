import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/providers/auth_provider.dart'; // Direct access to cleaner mock logic if needed, or AuthProvider
import '../../app/routes/app_pages.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Profile"),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            const CircleAvatar(
              radius: 50,
              backgroundColor: Colors.blueAccent,
              child: Icon(Icons.person, size: 50, color: Colors.white),
            ),
            const SizedBox(height: 10),
            const Text(
              "User Account",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const Text(
              "user@example.com",
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 30),

            _buildOptionTile(Icons.person_outline, "Edit Profile"),
            _buildOptionTile(Icons.notifications_outlined, "Notifications"),
            _buildOptionTile(Icons.language_outlined, "Language"),
            _buildOptionTile(Icons.security_outlined, "Security"),
            _buildOptionTile(Icons.help_outline, "Help & Support"),

            const SizedBox(height: 20),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text("Logout", style: TextStyle(color: Colors.red)),
              onTap: () {
                // Mock Logout
                Get.find<AuthProvider>().logout();
                Get.offAllNamed(Routes.login);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionTile(IconData icon, String title) {
    return ListTile(
      leading: Icon(icon, color: Colors.black87),
      title: Text(title),
      trailing: const Icon(Icons.chevron_right, color: Colors.grey),
      onTap: () {},
    );
  }
}
