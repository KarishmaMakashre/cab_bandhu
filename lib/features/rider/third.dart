import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'four.dart'; // DriverPickupVerificationScreen

class DriverNavigatePickupScreen extends StatelessWidget {
  const DriverNavigatePickupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212), // DARK BACKGROUND
      appBar: AppBar(
        backgroundColor: const Color(0xFF121212),
        elevation: 0,
        title: const Text(
          "Navigate to Pickup",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          /// 🗺️ MAP VIEW
          Expanded(
            child: Container(
              color: Colors.grey.shade900, // dark map background
              child: const Center(
                child: Text(
                  "Google Map View",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white70,
                  ),
                ),
              ),
            ).animate().fadeIn(duration: 500.ms).slideY(begin: -0.1),
          ),

          /// 🚕 BOTTOM INFO PANEL
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey.shade200, // DARK PANEL
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(0, -4),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                /// 👤 PASSENGER INFO
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 24,
                      backgroundImage:
                      NetworkImage("https://i.pravatar.cc/150?img=3"),
                    ),
                    const SizedBox(width: 12),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "Rahul Sharma",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "Pickup: Airport Road",
                            style: TextStyle(color: Colors.black45),
                          ),
                        ],
                      ),
                    ),

                    IconButton(
                      icon: const Icon(Icons.call, color: Colors.greenAccent),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: const Icon(Icons.chat, color: Colors.blueAccent),
                      onPressed: () {},
                    ),
                  ],
                ).animate().fadeIn(duration: 400.ms).slideX(begin: -0.2),

                const SizedBox(height: 16),

                /// 🚦 ARRIVED BUTTON
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.greenAccent,
                    minimumSize: const Size(double.infinity, 54),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      _slideRoute(const DriverPickupVerificationScreen()),
                    );
                  },
                  child: const Text(
                    "Arrived at Pickup",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.2),

                const SizedBox(height: 8),
              ],
            ),
          ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.1),
        ],
      ),
    ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.1);
  }
}

/// 🌟 CUSTOM PAGE TRANSITION
Route _slideRoute(Widget page) {
  return PageRouteBuilder(
    transitionDuration: const Duration(milliseconds: 400),
    pageBuilder: (_, __, ___) => page,
    transitionsBuilder: (_, animation, __, child) {
      return SlideTransition(
        position: Tween(
          begin: const Offset(1, 0),
          end: Offset.zero,
        ).animate(animation),
        child: FadeTransition(opacity: animation, child: child),
      );
    },
  );
}
