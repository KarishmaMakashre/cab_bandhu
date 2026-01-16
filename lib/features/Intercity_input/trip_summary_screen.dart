import 'package:flutter/material.dart';
import 'driver_dashboard_screen.dart';

class TripSummaryScreen extends StatelessWidget {
  const TripSummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Example trip data
    final int totalPassengers = 32;
    final int farePerSeat = 450;
    final int totalFare = totalPassengers * farePerSeat;

    return Scaffold(
      backgroundColor: Colors.grey.shade900, // dark background
      appBar: AppBar(
        backgroundColor: Colors.black87,
        iconTheme: const IconThemeData(color: Colors.white), // back button white
        title: const Text(
          "Trip Summary",
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 8),
            const Text(
              "Trip Completed!",
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.greenAccent),
            ),
            const SizedBox(height: 20),

            // Trip Info Cards
            summaryCard("Route", "Indore → Bhopal"),
            summaryCard("Driver", "Rahul Driver"),
            summaryCard("Start Time", "10:30 AM"),
            summaryCard("End Time", "2:00 PM"),
            summaryCard("Total Passengers", "$totalPassengers"),

            const Divider(
              height: 40,
              thickness: 1,
              color: Colors.white38,
            ),

            // Payment Info Cards
            summaryCard("Fare per Seat", "₹$farePerSeat"),
            summaryCard("Total Fare Collected", "₹$totalFare"),
            summaryCard("Payment Method", "Cash / Online"),

            const Spacer(),

            ElevatedButton(
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
                // Return to Driver Dashboard
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const DriverDashboardScreen()),
                      (route) => false,
                );
              },
              child: const Text(
                "Return to Dashboard",
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 18, letterSpacing: 0.5),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget summaryCard(String title, String value) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Colors.black54,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.bold)),
          Text(value,
              style: const TextStyle(
                  color: Colors.black45, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
