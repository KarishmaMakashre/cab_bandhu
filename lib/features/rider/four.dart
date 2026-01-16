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
      backgroundColor: const Color(0xFF121212), // 🔥 DARK BG
      appBar: AppBar(
        backgroundColor: const Color(0xFF121212),
        title: const Text(
          "Pickup Verification",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
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
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                "⭐ 4.8 • 52 trips",
                                style: TextStyle(color: Colors.black45),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: const [
                            Icon(Icons.verified_user, color: Colors.greenAccent),
                            SizedBox(height: 4),
                            Text(
                              "Verified",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.greenAccent,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ).animate().fadeIn(duration: 500.ms).slideX(begin: -0.2),

                  const SizedBox(height: 16),

                  /// 📍 PICKUP LOCATION
                  _card(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Icon(Icons.location_on, color: Colors.greenAccent),
                        SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Pickup Location",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                "Airport Road, Bhopal (Terminal 2)",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black45,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ).animate().fadeIn(duration: 500.ms).slideX(begin: 0.2),

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
                  ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.1),

                  const SizedBox(height: 30),

                  const Text(
                    "Enter Trip OTP",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.2),
                  const SizedBox(height: 6),
                  const Text(
                    "Ask passenger for the OTP to start trip",
                    style: TextStyle(color: Colors.white70),
                  ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.2),

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
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                        counterText: "",
                        filled: true,
                        fillColor: Colors.grey.shade900,
                        hintText: "• • • •",
                        hintStyle: const TextStyle(color: Colors.white54),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                  ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.2),

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
                        Icon(Icons.security, color: Colors.orangeAccent),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            "For your safety, never start the trip without OTP verification.",
                            style: TextStyle(fontSize: 13, color: Colors.white70),
                          ),
                        ),
                      ],
                    ),
                  ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.2),

                  const SizedBox(height: 20),

                  /// 🚨 LAST ROW EMERGENCY ICONS
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
                        label: "Emergency\nTRYDE",
                        color: Colors.blueAccent,
                        onTap: () {},
                      ),
                    ],
                  ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.2),
                ],
              ),
            ),
          ),

          /// 🔘 BOTTOM BUTTON
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.grey.shade900,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.greenAccent,
                minimumSize: const Size(double.infinity, 54),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
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
            ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.2),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.1); // Screen entry
  }

  Widget _card({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: Colors.grey.shade50, // Dark card
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }
}

/// 🚨 BOTTOM EMERGENCY ICON
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
        Text(title, style: const TextStyle(fontSize: 12, color: Colors.black)),
        const SizedBox(height: 6),
        Text(
          value,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black45),
        ),
      ],
    );
  }
}

/// 🌟 CUSTOM PAGE TRANSITION
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
