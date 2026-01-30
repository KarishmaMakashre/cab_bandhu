import 'package:cab_bandhu/core/constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../rider/custom_app_bar.dart';
import '../rider/second.dart';

class DriverDashboardScreen extends StatefulWidget {
  const DriverDashboardScreen({super.key});

  @override
  State<DriverDashboardScreen> createState() => _DriverDashboardScreenState();
}

class _DriverDashboardScreenState extends State<DriverDashboardScreen> {
  bool isOnline = false;
  bool hasRideRequest = false;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light, // Android → WHITE icons
        statusBarBrightness: Brightness.dark, // iOS → WHITE icons
      ),
      child: Scaffold(
        body: Stack(
          children: [
            /// 🌄 BACKGROUND IMAGE
            Positioned.fill(
              child: Image.asset(
                'assets/images/backgroundImg.jpeg',
                fit: BoxFit.cover,
              ),
            ),

            /// 🤍 WHITE OVERLAY (TEXT CLEAR)
            Positioned.fill(
              child: Container(
                color: Colors.white.withOpacity(0.88),
              ),
            ),

            /// MAIN CONTENT
            Column(
              children: [
                CustomHomeAppBar(
                  onDutyChanged: (value) {
                    setState(() {
                      isOnline = value;
                      hasRideRequest = value;
                    });
                  },
                ),

                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        if (isOnline && hasRideRequest)
                          _incomingRideCard()
                              .animate()
                              .fadeIn(duration: 300.ms)
                              .slideY(begin: 0.3),

                        const SizedBox(height: 26),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// ================= INCOMING RIDE =================
  Widget _incomingRideCard() {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 25,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Incoming Intercity Ride",
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.black
                ),
              ),
              Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text(
                  "00:25",
                  style: GoogleFonts.inter(
                    color: Colors.red,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          _locationRow(
            icon: Icons.my_location,
            value: "Bhopal Railway Station",
            color: Colors.green,
          ),
          const SizedBox(height: 12),
          _locationRow(
            icon: Icons.location_on,
            value: "Indore Vijay Nagar",
            color: Colors.redAccent,
          ),

          const Divider(height: 32),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              _InfoTile(title: "Distance", value: "186 km"),
              _InfoTile(title: "ETA", value: "3h 45m"),
              _InfoTile(title: "Vehicle", value: "Sedan"),
            ],
          ),

          const SizedBox(height: 14),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              _InfoTile(title: "Fare", value: "₹3,200"),
              _InfoTile(title: "Trip", value: "Intercity"),
              _InfoTile(title: "Payment", value: "Cash"),
            ],
          ),

          const SizedBox(height: 24),

          /// Buttons
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () =>
                      setState(() => hasRideRequest = false),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.red,
                    side: const BorderSide(color: Colors.red),
                  ),
                  child: Text(
                    "Reject",
                    style: GoogleFonts.inter(fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.foodPrimary,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                        const DriverRideAcceptedScreen(),
                      ),
                    );
                  },
                  child: Text(
                    "Accept Ride",
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _locationRow({
    required IconData icon,
    required String value,
    required Color color,
  }) {
    return Row(
      children: [
        Icon(icon, color: color, size: 18),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            value,
            style: GoogleFonts.inter(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Colors.black45
            ),
          ),
        ),
      ],
    );
  }
}

/// ================= INFO TILE =================
class _InfoTile extends StatelessWidget {
  final String title;
  final String value;

  const _InfoTile({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(title,
            style: GoogleFonts.inter(
              fontSize: 12,
              color: Colors.black45,
            )),
        const SizedBox(height: 4),
        Text(
          value,
          style: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
