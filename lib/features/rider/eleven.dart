import 'package:cab_bandhu/features/rider/twelve.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class TripHistoryScreen extends StatelessWidget {
  const TripHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                    "Trip History",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white, // WHITE TEXT
                    ),
                  ),
                ],
              ).animate().fadeIn(duration: 400.ms).slideX(begin: -0.1),

              const SizedBox(height: 16),

              /// 🧾 Section Title
              const Text(
                "Recent Trips",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.white, // WHITE TEXT
                ),
              ).animate().fadeIn(duration: 400.ms).slideX(begin: -0.1),

              const SizedBox(height: 12),

              /// 🚕 Trip List
              _tripTile(
                title: "Airport → MP Nagar",
                subtitle: "Today • 10:30 AM",
                amount: "₹320",
              ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.1),
              _tripTile(
                title: "ISBT → New Market",
                subtitle: "Yesterday • 8:15 PM",
                amount: "₹280",
              ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.1),
              _tripTile(
                title: "Railway Stn → Area Colony",
                subtitle: "Yesterday • 2:40 PM",
                amount: "₹410",
              ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.1),

              const SizedBox(height: 20),

              /// ⬇ Download Statement
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100, // Dark panel
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  children: const [
                    Icon(Icons.download, color: Colors.greenAccent), // Visible icon
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Download Statement",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.black, // WHITE TEXT
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "Daily / Weekly",
                            style: TextStyle(
                              color: Colors.black45, // LIGHT WHITE TEXT
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.1),

              const SizedBox(height: 20),

              /// 🎁 Offers Image
              ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: Image.network(
                  "https://images.unsplash.com/photo-1607082352121-fa243f3dde32",
                  height: 140,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.1),

              const Spacer(),

              /// ✅ Go to Wallet Button
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.greenAccent, // Visible button
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const WalletPayoutScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    "Go to Wallet",
                    style: TextStyle(
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

  /// 🚕 Trip Tile Widget
  Widget _tripTile({
    required String title,
    required String subtitle,
    required String amount,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.grey.shade100, // Dark panel
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.black, // WHITE TEXT
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.black45, // LIGHT WHITE TEXT
                  ),
                ),
              ],
            ),
          ),
          Text(
            amount,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: Colors.black, // WHITE TEXT
            ),
          ),
        ],
      ),
    );
  }
}
