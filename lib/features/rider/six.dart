import 'package:cab_bandhu/features/rider/seven.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class DriverTripStartedScreen extends StatelessWidget {
  const DriverTripStartedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212), // Dark background
      appBar: AppBar(
        backgroundColor: const Color(0xFF121212),
        elevation: 0,
        title: const Text(
          "Trip Started",
          style: TextStyle(color: Colors.white), // White text for visibility
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          /// MAP PLACEHOLDER
          Expanded(
            child: Container(
              color: Colors.grey.shade900,
              child: const Center(
                child: Text(
                  "LIVE NAVIGATION MAP",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white70, // visible on dark bg
                  ),
                ),
              ),
            ).animate().fadeIn(duration: 500.ms).slideY(begin: -0.1),
          ),

          /// ETA + ACTIONS
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey.shade100, // Dark gray panel
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(0, -4),
                ),
              ],
            ),
            child: Column(
              children: [
                _row("ETA", "12 mins"),
                _row("Remaining Distance", "6.1 km"),
                const SizedBox(height: 16),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.greenAccent,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const DriverReachDropScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    "Reached Drop Location",
                    style: TextStyle(
                      color: Colors.black, // visible on green button
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.2),
              ],
            ),
          ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.1),
        ],
      ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.1),
    );
  }

  Widget _row(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(color: Colors.black), // white text
          ),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black45, // white text
            ),
          ),
        ],
      ).animate().fadeIn(duration: 400.ms).slideX(begin: -0.1),
    );
  }
}
