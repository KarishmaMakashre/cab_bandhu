import 'package:cab_bandhu/core/constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // ✅ ADDED
import 'eleven.dart';
import 'package:flutter_animate/flutter_animate.dart';

class EarningsUpdatedScreen extends StatelessWidget {
  const EarningsUpdatedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // ✅ STATUS BAR CONFIG
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light,
      ),
    );

    return Scaffold(
      backgroundColor: Colors.transparent, // ✅ ADDED
      body: Stack(
        children: [
          /// 🖼️ BACKGROUND IMAGE
          Positioned.fill(
            child: Image.asset(
              "assets/images/backgroundImg.jpeg",
              fit: BoxFit.cover,
            ),
          ),

          /// 🌫️ SOFT OVERLAY (premium trip feel)
          Positioned.fill(
            child: Container(
              color: Colors.white.withOpacity(0.85),
            ),
          ),

          /// ✅ ORIGINAL CONTENT (UNCHANGED)
          Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  /// 🏦 Wallet Icon
                  Container(
                    padding: const EdgeInsets.all(22),
                    decoration: BoxDecoration(
                      color: AppColors.ridePrimary.withOpacity(0.15),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.account_balance_wallet,
                      size: 48,
                      color: AppColors.ridePrimary,
                    ),
                  )
                      .animate()
                      .fadeIn(duration: 400.ms)
                      .slideY(begin: -0.2),

                  const SizedBox(height: 24),

                  /// 💰 Earnings Text
                  const Text(
                    "₹340 added to your earnings",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  )
                      .animate()
                      .fadeIn(duration: 400.ms)
                      .slideY(begin: -0.1),

                  const SizedBox(height: 10),

                  const Text(
                    "Your wallet balance has been updated",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  )
                      .animate()
                      .fadeIn(duration: 400.ms)
                      .slideY(begin: -0.1),

                  const SizedBox(height: 36),

                  /// ✅ View Trip History Button
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.ridebtn,
                        elevation: 2,
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
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    )
                        .animate()
                        .fadeIn(duration: 500.ms)
                        .slideY(begin: 0.1),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
