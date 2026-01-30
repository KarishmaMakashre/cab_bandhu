import 'package:cab_bandhu/core/constants/color_constants.dart';
import 'package:cab_bandhu/features/rider/seven.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';

class DriverTripStartedScreen extends StatelessWidget {
  const DriverTripStartedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.white, // ✅ WHITE STATUS BAR
        statusBarIconBrightness: Brightness.dark, // ✅ BLACK ICONS
        statusBarBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,

        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.5,
          title: const Text(
            "Trip Started",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
          iconTheme: const IconThemeData(color: Colors.black),
        ),

        body: Stack(
          children: [
            /// 🌄 BACKGROUND IMAGE (BEHIND EVERYTHING)
            Positioned.fill(
              child: Image.asset(
                "assets/images/backgroundImg.jpeg",
                fit: BoxFit.cover,
                opacity: const AlwaysStoppedAnimation(0.12), // subtle
              ),
            ),

            /// 🔳 EXISTING UI (UNCHANGED)
            Column(
              children: [
                /// 🗺️ LIVE MAP
                Expanded(
                  child: Container(
                    color: Colors.grey.shade300.withOpacity(0.9),
                    child: const Center(
                      child: Text(
                        "LIVE NAVIGATION MAP",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ).animate().fadeIn().slideY(begin: -0.1),
                ),

                /// 🔽 BOTTOM PANEL
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                  child: Stack(
                    children: [
                      /// 🌄 BG IMAGE
                      Positioned.fill(
                        child: Image.asset(
                          "assets/images/backgroundImg.jpeg",
                          fit: BoxFit.cover,
                        ),
                      ),

                      /// 🌫 WHITE OVERLAY (for readability)
                      Positioned.fill(
                        child: Container(
                          color: Colors.white.withOpacity(0.92),
                        ),
                      ),

                      /// 🧱 CONTENT
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(20),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.12),
                              blurRadius: 12,
                              offset: const Offset(0, -4),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _row("ETA", "12 mins"),
                            _row("Remaining Distance", "6.1 km"),
                            const SizedBox(height: 16),

                            /// ✅ ACTION BUTTON
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.ridePrimary,
                                minimumSize: const Size(double.infinity, 52),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const DriverReachDropScreen(),
                                  ),
                                );
                              },
                              child: const Text(
                                "Reached Drop Location",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            )
                                .animate()
                                .fadeIn(duration: 400.ms)
                                .slideY(begin: 0.2),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
                    .animate()
                    .fadeIn(duration: 400.ms)
                    .slideY(begin: 0.1),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// 📊 INFO ROW (UNCHANGED)
  Widget _row(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Colors.black54,
              fontSize: 14,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 15,
            ),
          ),
        ],
      ).animate().fadeIn().slideX(begin: -0.1),
    );
  }
}
