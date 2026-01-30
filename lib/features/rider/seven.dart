import 'package:cab_bandhu/core/constants/color_constants.dart';
import 'package:cab_bandhu/features/rider/seven_eight.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';

class DriverReachDropScreen extends StatelessWidget {
  const DriverReachDropScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            /// 🖼️ BACKGROUND IMAGE (CLEAR)
            Positioned.fill(
              child: Image.asset(
                'assets/images/backgroundImg.jpeg',
                fit: BoxFit.cover,
              ),
            ),

            /// 🌫️ LIGHT OVERLAY (image still visible)
            Positioned.fill(
              child: Container(
                color: Colors.white.withOpacity(0.80), // 🔥 adjust if needed
              ),
            ),

            /// ✅ MAIN CONTENT
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// 🔙 BACK + TITLE
                    Row(
                      children: const [
                        Icon(Icons.arrow_back, color: Colors.black87),
                        SizedBox(width: 12),
                        Text(
                          "Drop Location",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ).animate().fadeIn().slideX(begin: -0.1),

                    const SizedBox(height: 24),

                    /// 🚩 REACHED CARD
                    _card(
                      child: Column(
                        children: const [
                          CircleAvatar(
                            radius: 30,
                            backgroundColor: AppColors.ridePrimary,
                            child: Icon(Icons.flag,
                                color: Colors.white, size: 28),
                          ),
                          SizedBox(height: 14),
                          Text(
                            "You've reached the drop location",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    /// 📍 ADDRESS CARD
                    _card(
                      child: Row(
                        children: const [
                          Icon(Icons.location_on, color: Colors.redAccent),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              "MP Nagar Zone 2, Bhopal",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    /// 📊 TRIP INFO
                    _card(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: const [
                          _InfoTile(title: "Distance", value: "8.4 km"),
                          _InfoTile(title: "Fare", value: "₹320"),
                          _InfoTile(title: "Payment", value: "Cash"),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    /// 🧾 SECTION TITLE
                    const Text(
                      "Offers & Captain Alerts",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ).animate().fadeIn().slideX(begin: -0.1),

                    const SizedBox(height: 10),

                    /// 🖼 OFFER IMAGE
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.network(
                        "https://plus.unsplash.com/premium_photo-1684407617181-275e50374e95?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTN8fHRyYXZlbGluZ3xlbnwwfHwwfHx8MA%3D%3D",
                        height: w * 0.45,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ).animate().fadeIn().slideY(begin: 0.1),

                    const Spacer(),

                    /// 🚗 COMPLETE TRIP BUTTON
                    SizedBox(
                      width: double.infinity,
                      height: 54,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.ridePrimary,
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
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ).animate().fadeIn().slideY(begin: 0.1),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 🧱 REUSABLE CARD
  Widget _card({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.96),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: child,
    ).animate().fadeIn().slideY(begin: 0.1);
  }
}

/// 🔹 INFO TILE
class _InfoTile extends StatelessWidget {
  final String title;
  final String value;

  const _InfoTile({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.black54,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}
