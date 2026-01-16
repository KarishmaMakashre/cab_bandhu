
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profile")),
      body: Column(
        children: const [
          SizedBox(height: 20),
          CircleAvatar(
            radius: 50,
            backgroundImage:
            NetworkImage("https://i.imgur.com/QCNbOAo.png"),
          ),
          SizedBox(height: 12),
          Text("Rahul Driver",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Text("MP09 AB 1234"),
        ],
      ),
    );
  }
}
