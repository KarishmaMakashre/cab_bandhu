import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/constants/color_constants.dart';
import '../porter_partner/screens/porter_dashboard_screen.dart';
import 'first.dart';
import 'package:flutter_animate/flutter_animate.dart';

class WalletPayoutScreen extends StatelessWidget {
  const WalletPayoutScreen({super.key});

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
                  Icon(Icons.arrow_back, color: Colors.white),
                  SizedBox(width: 12),
                  Text(
                    "Wallet & Payout",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ],
              ).animate().fadeIn(duration: 400.ms).slideX(begin: -0.1),

              const SizedBox(height: 20),

              /// 💰 Balance Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.greenAccent, // Panel
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Available Balance",
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 13,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "₹5,420",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.1),

              const SizedBox(height: 24),

              /// 💸 Payout Options Title
              const Text(
                "Payout Options",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ).animate().fadeIn(duration: 400.ms).slideX(begin: -0.1),

              const SizedBox(height: 12),

              /// 💸 Option Tiles
              _optionTile(
                icon: Icons.account_balance,
                title: "Bank Transfer",
                subtitle: "Withdraw money to your bank account",
                onTap: () {},
              ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.1),

              const SizedBox(height: 10),

              _optionTile(
                icon: Icons.qr_code,
                title: "UPI Transfer",
                subtitle: "Instant payout to UPI",
                onTap: () {},
              ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.1),

              const SizedBox(height: 24),

              /// 🎁 Rewards Title
              const Text(
                "Rewards & Incentives",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ).animate().fadeIn(duration: 400.ms).slideX(begin: -0.1),

              const SizedBox(height: 12),

              _optionTile(
                icon: Icons.card_giftcard,
                title: "Incentives & Bonus",
                subtitle: "View today’s rewards and bonuses",
                onTap: () {},
              ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.1),

              const SizedBox(height: 24),

              /// 🖼 Offers Image
              ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: Image.network(
                  "https://images.unsplash.com/photo-1520975916090-3105956dac38",
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.1),

              const Spacer(),

              /// ✅ Go to Dashboard Button
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
                  onPressed: () async {
                    final prefs = await SharedPreferences.getInstance();
                    final role = prefs.getString('user_role');
                    debugPrint('User role from prefs: $role');
                    if (role == 'rider') {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const HomeScreen(),
                        ),
                            (route) => false,
                      );
                    } else {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const PartnerDashboard(),
                        ),
                            (route) => false,
                      );
                    }
                  },
                  child: const Text(
                    "Go to dashboard",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
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

  /// 🔹 Option Tile Widget
  Widget _optionTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.grey.shade100, // Panel
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 22,
              backgroundColor: Colors.greenAccent.withOpacity(0.3),
              child: Icon(icon, color: Colors.greenAccent),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      )),
                  const SizedBox(height: 4),
                  Text(subtitle,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black54,
                      )),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: Colors.black),
          ],
        ),
      ),
    );
  }
}
