import 'package:flutter/material.dart';
import 'eleven.dart';
import 'package:flutter_animate/flutter_animate.dart';

class EarningsUpdatedScreen extends StatelessWidget {
  const EarningsUpdatedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212), // Dark background
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              /// 🏦 Wallet Icon
              const Icon(Icons.account_balance_wallet,
                  size: 80, color: Colors.green)
                  .animate().fadeIn(duration: 400.ms).slideY(begin: -0.2),

              const SizedBox(height: 20),

              /// 💰 Earnings Text
              const Text(
                "₹340 added to your earnings",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // WHITE TEXT
                ),
              ).animate().fadeIn(duration: 400.ms).slideY(begin: -0.1),

              const SizedBox(height: 30),

              /// ✅ View Trip History Button
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.greenAccent, // Visible button
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const TripHistoryScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    "View Trip History",
                    style: TextStyle(
                      color: Colors.black, // BLACK BUTTON TEXT
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
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
