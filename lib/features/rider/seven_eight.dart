import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'eight.dart';

class DriverCollectPaymentScreen extends StatelessWidget {
  final double amount;
  final String bookingId;
  final String customerName;

  const DriverCollectPaymentScreen({
    super.key,
    required this.amount,
    required this.bookingId,
    required this.customerName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212), // Dark background
      appBar: AppBar(
        backgroundColor: const Color(0xFF121212),
        title: const Text(
          "Collect Payment",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _amountCard().animate().fadeIn(duration: 500.ms).slideY(begin: -0.1),
            const SizedBox(height: 20),
            _qrCard().animate().fadeIn(duration: 500.ms).slideY(begin: -0.1),
            const SizedBox(height: 20),

            /// 💵 COLLECT CASH BUTTON
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.greenAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () => _showCashConfirm(context),
                child: const Text(
                  "Collect Cash",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black, // Button text black for visibility
                  ),
                ),
              ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.1),
            ),

            const Spacer(),

            const Text(
              "Please collect payment before ending the ride",
              style: TextStyle(color: Colors.white70), // light white text
            ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.1),
          ],
        ),
      ),
    );
  }

  /// ---------------- AMOUNT CARD ----------------
  Widget _amountCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey.shade100, // info panel
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 8)],
      ),
      child: Column(
        children: [
          const Text(
            "Amount to Collect",
            style: TextStyle(color: Colors.black54),
          ),
          const SizedBox(height: 10),
          Text(
            "₹ ${amount.toStringAsFixed(2)}",
            style: const TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            "Customer: $customerName",
            style: const TextStyle(color: Colors.black54),
          ),
        ],
      ),
    );
  }

  /// ---------------- QR CARD ----------------
  Widget _qrCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey.shade100, // info panel
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 8)],
      ),
      child: Column(
        children: const [
          Text(
            "Scan QR to Pay",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black, // black text for contrast
            ),
          ),
          SizedBox(height: 16),
          Icon(Icons.qr_code_2, size: 150, color: Colors.black54),
          SizedBox(height: 12),
          Text(
            "Ask customer to scan & pay",
            style: TextStyle(color: Colors.black54),
          ),
        ],
      ),
    );
  }

  /// ---------------- CASH CONFIRM ----------------
  void _showCashConfirm(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: const Color(0xFF1E1E1E), // dark dialog
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: const Text(
          "Cash Collected?",
          style: TextStyle(color: Colors.white),
        ),
        content: const Text(
          "Have you received the full cash amount?",
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("No", style: TextStyle(color: Colors.white)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => const DriverTripCompletedScreen(),
                ),
              );
            },
            child: const Text(
              "Yes, Collected",
              style: TextStyle(color: Colors.greenAccent),
            ),
          ),
        ],
      ),
    );
  }
}
