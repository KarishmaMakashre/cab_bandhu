import 'package:flutter/material.dart';
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
    return Scaffold(
      backgroundColor: const Color(0xffF4F6FA),
      appBar: CustomHomeAppBar(
        onDutyChanged: (value) {
          setState(() {
            isOnline = value;
            hasRideRequest = value; // demo purpose
          });
        },
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            const SizedBox(height: 12),

            if (isOnline && hasRideRequest)
              _incomingRideCard()
                  .animate()
                  .fadeIn(duration: 300.ms)
                  .slideY(begin: 0.3),

            const SizedBox(height: 26),

            Text(
              isOnline ? "Driver Mode Active" : "You are Offline",
              style: GoogleFonts.inter(
                fontSize: 13,
                color: Colors.black54,
                fontWeight: FontWeight.w600,
              ),
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
            color: Colors.black.withOpacity(0.08),
            blurRadius: 30,
            offset: const Offset(0, 15),
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
                "Incoming Ride",
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
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
            value: "MP Nagar Zone 2",
            color: Colors.redAccent,
          ),

          const Divider(height: 32),

          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _InfoTile(title: "Distance", value: "6.2 km"),
              _InfoTile(title: "Fare", value: "₹320"),
              _InfoTile(title: "Payment", value: "Cash"),
            ],
          ),

          const SizedBox(height: 22),

          /// Buttons
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () =>
                      setState(() => hasRideRequest = false),
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
                    backgroundColor: Colors.green,
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
            ),
          ),
        ),
      ],
    );
  }
}

/// ================= STAT CARD =================
Widget _statCard({
  required String title,
  required String value,
  required IconData icon,
  required List<Color> gradient,
}) {
  return Container(
    height: 120,
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: gradient,
      ),
      borderRadius: BorderRadius.circular(22),
    ),
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: Colors.white),
        const Spacer(),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          title,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 12,
          ),
        ),
      ],
    ),
  );
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
              color: Colors.black54,
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
