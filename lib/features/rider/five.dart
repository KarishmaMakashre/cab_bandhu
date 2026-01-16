import 'package:cab_bandhu/features/rider/six.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class DriverTripInProgressScreen extends StatelessWidget {
  const DriverTripInProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212), // Dark background
      appBar: AppBar(
        backgroundColor: const Color(0xFF121212),
        title: const Text(
          "Trip In Progress",
          style: TextStyle(color: Colors.black), // BLACK TEXT
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Column(
        children: [
          /// 🗺️ LIVE MAP
          Expanded(
            child: Stack(
              children: [
                Container(
                  color: Colors.grey.shade900, // dark map background
                  child: const Center(
                    child: Text(
                      "LIVE NAVIGATION MAP",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black, // BLACK TEXT
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ).animate().fadeIn(duration: 500.ms).slideY(begin: -0.1),

                /// 🔴 TRIP STATUS CHIP
                Positioned(
                  top: 16,
                  left: 16,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      "TRIP ACTIVE",
                      style: TextStyle(
                        color: Colors.black, // BLACK TEXT
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ).animate().fadeIn(duration: 500.ms).slideX(begin: -0.2),
                ),
              ],
            ),
          ),

          /// 🔽 BOTTOM SHEET
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey.shade100, // dark bottom panel
              borderRadius:
              const BorderRadius.vertical(top: Radius.circular(20)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 10,
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
                      radius: 22,
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
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black, // BLACK TEXT
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            "⭐ 4.8 rating",
                            style: TextStyle(color: Colors.black),
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

                const SizedBox(height: 14),

                /// 📍 ROUTE INFO
                _routeRow(
                  icon: Icons.location_on,
                  color: Colors.greenAccent,
                  label: "Pickup",
                  value: "Airport Road, Bhopal",
                ).animate().fadeIn(duration: 400.ms).slideX(begin: -0.2),
                const SizedBox(height: 8),
                _routeRow(
                  icon: Icons.flag,
                  color: Colors.redAccent,
                  label: "Drop",
                  value: "MP Nagar Zone 2",
                ).animate().fadeIn(duration: 400.ms).slideX(begin: 0.2),

                const SizedBox(height: 16),

                /// 📊 LIVE STATS
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const [
                    _TripStat(title: "Distance", value: "5.2 km"),
                    _TripStat(title: "Time", value: "18 min"),
                    _TripStat(title: "ETA", value: "7 min"),
                  ],
                ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.1),

                const SizedBox(height: 20),

                /// 🛑 END TRIP BUTTON
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    minimumSize: const Size(double.infinity, 54),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const DriverTripStartedScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    "End Trip",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black, // BLACK BUTTON TEXT
                    ),
                  ),
                ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.2),

                const SizedBox(height: 8),
              ],
            ),
          ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.1),
        ],
      ),
    );
  }

  /// 📍 ROUTE ROW
  Widget _routeRow({
    required IconData icon,
    required Color color,
    required String label,
    required String value,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: color, size: 18),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.black, // BLACK TEXT
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black, // BLACK TEXT
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// 📊 STAT WIDGET
class _TripStat extends StatelessWidget {
  final String title;
  final String value;

  const _TripStat({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.black, // BLACK TEXT
          ),
        ),
        const SizedBox(height: 6),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black, // BLACK TEXT
          ),
        ),
      ],
    );
  }
}
