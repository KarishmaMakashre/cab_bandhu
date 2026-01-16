import 'package:flutter/material.dart';
import 'live_trip_screen.dart';

class TripMapPreviewScreen extends StatelessWidget {
  const TripMapPreviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final String mapUrl =
        "https://media.istockphoto.com/id/1189064346/photo/city-map-with-pin-pointers-3d-rendering-image.webp?a=1&b=1&s=612x612&w=0&k=20&c=ATkI2VsMyZ2K4zk-Qq12g6cRpO2VJvt6UPPDb_sshSg=";

    return Scaffold(
      backgroundColor: Colors.grey.shade900, // dark background
      appBar: AppBar(
        backgroundColor: Colors.black87,
        iconTheme: const IconThemeData(color: Colors.white), // <-- back button color
        title: const Text(
          "Trip Map Preview",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        children: [
          // Map full screen
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(0),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black54,
                    blurRadius: 8,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: ClipRRect(
                child: Image.network(
                  mapUrl,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          // Continue Button
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 55),
                backgroundColor: Colors.greenAccent.shade400,
                foregroundColor: Colors.black,
                elevation: 6,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                shadowColor: Colors.black54,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const LiveTripScreen()),
                );
              },
              child: const Text(
                "Continue Trip",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    letterSpacing: 0.5),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
