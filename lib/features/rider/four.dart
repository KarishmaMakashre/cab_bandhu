import 'package:cab_bandhu/core/constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'five.dart'; // DriverTripInProgressScreen

class DriverPickupVerificationScreen extends StatefulWidget {
  const DriverPickupVerificationScreen({super.key});

  @override
  State<DriverPickupVerificationScreen> createState() =>
      _DriverPickupVerificationScreenState();
}

class _DriverPickupVerificationScreenState
    extends State<DriverPickupVerificationScreen> {
  final TextEditingController otpController = TextEditingController();
  final String correctOtp = "1234";

  @override
  void dispose() {
    otpController.dispose();
    super.dispose();
  }

  void _verifyOtp() {
    if (otpController.text == correctOtp) {
      Navigator.push(
        context,
        _slideRoute(const DriverTripInProgressScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Incorrect OTP. Please verify with passenger."),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF6F7FB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Pickup Verification",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  /// 👤 PASSENGER CARD
                  _card(
                    child: Row(
                      children: [
                        const CircleAvatar(
                          radius: 28,
                          backgroundImage:
                          NetworkImage("https://i.pravatar.cc/150?img=3"),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                "Rahul Sharma",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                "⭐ 4.8 • 52 trips",
                                style: TextStyle(color: Colors.black54),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: const [
                            Icon(Icons.verified_user,
                                color: Colors.green),
                            SizedBox(height: 4),
                            Text(
                              "Verified",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.green,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                      .animate()
                      .fadeIn(duration: 400.ms)
                      .slideX(begin: -0.2),

                  const SizedBox(height: 16),

                  /// 📍 PICKUP LOCATION
                  _card(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Icon(Icons.location_on, color: Colors.green),
                        SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Pickup Location",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black54,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                "Airport Road, Bhopal (Terminal 2)",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                      .animate()
                      .fadeIn(duration: 400.ms)
                      .slideX(begin: 0.2),

                  const SizedBox(height: 16),

                  /// 🚕 TRIP SUMMARY
                  _card(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: const [
                        _TripStat(title: "Distance", value: "8.4 km"),
                        _TripStat(title: "Fare", value: "₹320"),
                        _TripStat(title: "Payment", value: "Cash"),
                      ],
                    ),
                  )
                      .animate()
                      .fadeIn(duration: 400.ms)
                      .slideY(begin: 0.1),

                  const SizedBox(height: 30),

                  const Text(
                    "Enter Trip OTP",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                      .animate()
                      .fadeIn()
                      .slideY(begin: 0.2),

                  const SizedBox(height: 6),

                  const Text(
                    "Ask passenger for the OTP to start trip",
                    style: TextStyle(color: Colors.black54),
                  )
                      .animate()
                      .fadeIn()
                      .slideY(begin: 0.2),

                  const SizedBox(height: 24),

                  /// 🔢 OTP INPUT
                  SizedBox(
                    width: 200,
                    child: TextField(
                      controller: otpController,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      maxLength: 4,
                      style: const TextStyle(
                        fontSize: 26,
                        letterSpacing: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: InputDecoration(
                        counterText: "",
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "• • • •",
                        hintStyle:
                        const TextStyle(color: Colors.black38),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide:
                          BorderSide(color: Colors.grey.shade300),
                        ),
                      ),
                    ),
                  )
                      .animate()
                      .fadeIn()
                      .slideY(begin: 0.2),

                  const SizedBox(height: 12),

                  /// 🛡️ SAFETY NOTE
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.orange.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: const [
                        Icon(Icons.security, color: Colors.orange),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            "For your safety, never start the trip without OTP verification.",
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                      .animate()
                      .fadeIn()
                      .slideY(begin: 0.2),

                  const SizedBox(height: 20),

                  /// 🚨 EMERGENCY ACTIONS
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _BottomEmergencyIcon(
                        icon: Icons.local_police,
                        label: "Emergency\nPolice",
                        color: Colors.redAccent,
                        onTap: () {},
                      ),
                      _BottomEmergencyIcon(
                        icon: Icons.support_agent,
                        label: "Emergency\nCAB BANDHU",
                        color: Colors.blueAccent,
                        onTap: () {},
                      ),
                    ],
                  )
                      .animate()
                      .fadeIn()
                      .slideY(begin: 0.2),
                ],
              ),
            ),
          ),

          /// 🔘 BOTTOM BUTTON
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.ridePrimary,
                minimumSize: const Size(double.infinity, 54),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 4,
              ),
              onPressed: _verifyOtp,
              child: const Text(
                "Verify OTP & Start Trip",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            )
                .animate()
                .fadeIn()
                .slideY(begin: 0.2),
          ),
        ],
      ),
    )
        .animate()
        .fadeIn(duration: 350.ms)
        .slideY(begin: 0.1);
  }

  Widget _card({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: child,
    );
  }
}

/// 🚨 EMERGENCY ICON
class _BottomEmergencyIcon extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _BottomEmergencyIcon({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(40),
      child: Column(
        children: [
          CircleAvatar(
            radius: 26,
            backgroundColor: color.withOpacity(0.15),
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

/// 📊 TRIP STAT
class _TripStat extends StatelessWidget {
  final String title;
  final String value;

  const _TripStat({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style:
          const TextStyle(fontSize: 12, color: Colors.black54),
        ),
        const SizedBox(height: 6),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

/// 🚀 PAGE TRANSITION
Route _slideRoute(Widget page) {
  return PageRouteBuilder(
    transitionDuration: const Duration(milliseconds: 400),
    pageBuilder: (_, __, ___) => page,
    transitionsBuilder: (_, animation, __, child) {
      return SlideTransition(
        position: Tween(
          begin: const Offset(1, 0),
          end: Offset.zero,
        ).animate(animation),
        child: FadeTransition(opacity: animation, child: child),
      );
    },
  );
}
