import 'package:flutter/material.dart';
import 'live_trip_screen.dart';

class TripDetailsScreen extends StatelessWidget {
  const TripDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Trip Details")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            tripRow("Route", "Indore → Bhopal"),
            tripRow("Departure Time", "10:30 AM"),
            tripRow("Estimated Arrival", "2:00 PM"),
            tripRow("Bus Number", "MP09 AB 1234"),
            tripRow("Driver", "Rahul Driver"),
            tripRow("Passengers Booked", "32 / 40"),
            tripRow("Status", "Not Started"),
            tripRow("Fare per Seat", "₹450"),

            const Spacer(),

            ElevatedButton(
              style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 50)),
              onPressed: () {
                // Navigate to Live Trip / Tracking Screen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const LiveTripScreen()),
                );
              },
              child: const Text("Start Trip"),
            )
          ],
        ),
      ),
    );
  }

  Widget tripRow(String title, String value) {
    return ListTile(
      title: Text(title),
      trailing: Text(value),
    );
  }
}
