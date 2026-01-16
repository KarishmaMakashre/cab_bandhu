import 'package:cab_bandhu/features/rider/seven_eight.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class DriverReachDropScreen extends StatelessWidget {
  const DriverReachDropScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFF121212), // Dark background
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// 🔙 Back + Title
              Row(
                children: const [
                  Icon(Icons.arrow_back, color: Colors.white), // WHITE ICON
                  SizedBox(width: 12),
                  Text(
                    "Drop Location",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white, // WHITE TEXT
                    ),
                  )
                ],
              ).animate().fadeIn(duration: 400.ms).slideX(begin: -0.1),

              const SizedBox(height: 24),

              /// ✅ Reached Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 30),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100, // Dark panel for visibility
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Column(
                  children: const [
                    CircleAvatar(
                      radius: 28,
                      backgroundColor: Colors.green,
                      child: Icon(Icons.flag, color: Colors.white, size: 28),
                    ),
                    SizedBox(height: 14),
                    Text(
                      "You've reached the drop location",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black, // Text visible on light card
                      ),
                    )
                  ],
                ),
              ).animate().fadeIn(duration: 400.ms).slideY(begin: -0.1),

              const SizedBox(height: 20),

              /// 📍 Address
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100, // Dark panel
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: const [
                    Icon(Icons.location_on, color: Colors.red),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        "MP Nagar Zone 2, Bhopal",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black, // BLACK TEXT on light panel
                        ),
                      ),
                    )
                  ],
                ),
              ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.1),

              const SizedBox(height: 16),

              /// 📊 Trip Info
              Container(
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100, // Dark panel
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const [
                    _InfoTile(title: "Distance", value: "8.4 km"),
                    _InfoTile(title: "Fare", value: "₹320"),
                    _InfoTile(title: "Payment", value: "Cash"),
                  ],
                ),
              ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.1),

              const SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: const Text(
                  "Offers & Captain Alerts",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.white, // WHITE TEXT
                  ),
                ),
              ).animate().fadeIn(duration: 400.ms).slideX(begin: -0.1),
              const SizedBox(height: 10),

              /// 🖼 Offer Image
              ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: Image.network(
                  "https://images.unsplash.com/photo-1520975916090-3105956dac38",
                  height: w * 0.45,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.1),

              const Spacer(),

              /// 🚗 Complete Trip Button
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.greenAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const DriverCollectPaymentScreen(
                          amount: 320,
                          bookingId: "BK10245",
                          customerName: "Rahul Sharma",
                        ),
                      ),
                    );
                  },
                  child: const Text(
                    "Complete Trip",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black, // BLACK BUTTON TEXT
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.1),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// 🔹 Small Info Widget
class _InfoTile extends StatelessWidget {
  final String title;
  final String value;

  const _InfoTile({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(title, style: const TextStyle(fontSize: 12, color: Colors.black)),
        const SizedBox(height: 6),
        Text(
          value,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black45),
        ),
      ],
    ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.1);
  }
}
