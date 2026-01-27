import 'package:flutter/material.dart';
import 'driver_dashboard_screen.dart';

class TripSummaryScreen extends StatelessWidget {
  const TripSummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final int totalPassengers = 32;
    final int farePerSeat = 450;
    final int totalFare = totalPassengers * farePerSeat;

    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB), // light background
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          "Trip Summary",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 8),

            /// Success Icon
            Container(
              height: 72,
              width: 72,
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.15),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check_circle,
                size: 42,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 12),

            /// Title
            const Text(
              "Trip Completed!",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 20),

            /// Trip Details Card
            _sectionCard(
              title: "Trip Details",
              children: [
                summaryRow("Route", "Indore → Bhopal"),
                summaryRow("Driver", "Rahul Driver"),
                summaryRow("Start Time", "10:30 AM"),
                summaryRow("End Time", "2:00 PM"),
                summaryRow("Passengers", "$totalPassengers"),
              ],
            ),

            const SizedBox(height: 16),

            /// Payment Details Card
            _sectionCard(
              title: "Payment Summary",
              children: [
                summaryRow("Fare per Seat", "₹$farePerSeat"),
                summaryRow(
                  "Total Fare",
                  "₹$totalFare",
                  highlight: true,
                ),
                summaryRow("Payment Method", "Cash / Online"),
              ],
            ),

            const Spacer(),

            /// Back to Dashboard Button
            SafeArea(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 56),
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const DriverDashboardScreen(),
                    ),
                        (route) => false,
                  );
                },
                child: const Text(
                  "Return to Dashboard",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    letterSpacing: 0.4,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Section Card
  Widget _sectionCard({
    required String title,
    required List<Widget> children,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 12),
          ...children,
        ],
      ),
    );
  }

  /// Summary Row
  Widget summaryRow(String title, String value, {bool highlight = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.black54,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: highlight ? Colors.green : Colors.black87,
              fontSize: highlight ? 16 : 14,
            ),
          ),
        ],
      ),
    );
  }
}
