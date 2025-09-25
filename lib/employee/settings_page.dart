import 'package:flutter/material.dart';
import 'app_drawer.dart';

void main() {
  runApp(const MaterialApp(home: SettingsPage()));
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF7F7),
      appBar: AppBar(
        title: const Text('Settings', style: TextStyle(fontSize: 24)),
        centerTitle: true,
        backgroundColor: Color(0xFF5B41F5),
        elevation: 0,
      ),
      drawer: const EmployeeAppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade300,
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: ListView(
            children: [
              _buildTile(Icons.wifi, "Wireless & networks", Colors.blue),
              _buildTile(Icons.notifications, "Notification", Colors.red),
              _buildTile(Icons.volume_up, "Sound", Colors.purple),
              _buildTile(Icons.brightness_6, "Display", Colors.green),
              _buildTile(Icons.lock, "Security", Colors.teal),
              _buildTile(Icons.privacy_tip, "Privacy", Colors.blueAccent),
              _buildTile(Icons.info, "About", Colors.indigo),
              _buildTile(Icons.accessibility, "Accessibility", Colors.green),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTile(IconData icon, String title, Color color) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 8),
      leading: Icon(icon, color: color),
      title: Text(title, style: const TextStyle(fontSize: 16)),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () {},
    );
  }
}
