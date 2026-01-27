import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'custom_app_bar.dart';
import 'second.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isOnline = true;
  bool hasRideRequest = true;

  final List<String> adsImages = [
    "https://images.unsplash.com/photo-1611162617474-5b21e879e113",
  ];

  @override
  void initState() {
    super.initState();
    _showFirstTimePopup();
  }

  Future<void> _showFirstTimePopup() async {
    final prefs = await SharedPreferences.getInstance();
    final shown = prefs.getBool('caution_shown') ?? false;

    if (!shown) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: Text(
              "Important Instructions",
              style: GoogleFonts.inter(fontWeight: FontWeight.w700),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _bullet("Location access is required"),
                _bullet("Background tracking during trips"),
                _bullet("Follow pickup & drop rules"),
              ],
            ),
            actions: [
              ElevatedButton(
                onPressed: () async {
                  await prefs.setBool('caution_shown', true);
                  Navigator.pop(context);
                },
                child: Text(
                  "Agree & Continue",
                  style: GoogleFonts.inter(fontWeight: FontWeight.w600),
                ),
              )
            ],
          ),
        );
      });
    }
  }

  Widget _bullet(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text("• $text", style: GoogleFonts.inter()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF4F6FA),
      appBar: CustomHomeAppBar(
        onDutyChanged: (value) {
          setState(() {
            isOnline = value;
            hasRideRequest = value;
          });
        },
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _statsRow(),

            const SizedBox(height: 22),

            if (isOnline && hasRideRequest)
              _incomingRideCard()
                  .animate()
                  .fadeIn()
                  .slideY(begin: 0.3),

            const SizedBox(height: 26),

            _offersSection(),

            const SizedBox(height: 20),

            Text(
              "Driver Mode Active",
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


  /// ================= STATS =================
  Widget _statsRow() {
    return Row(
      children: [
        Expanded(
          child: _statCard(
            title: "Earnings",
            value: "₹1,250",
            icon: Icons.account_balance_wallet,
            gradient: const [Color(0xff43CEA2), Color(0xff185A9D)],
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: _statCard(
            title: "Trips",
            value: "8",
            icon: Icons.route,
            gradient: const [Color(0xffF7971E), Color(0xffFFD200)],
          ),
        ),
      ],
    );
  }

  /// ================= INCOMING RIDE =================
  Widget _incomingRideCard() {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xffEFFAED),
            Color(0xffffffff),
          ],
        ),
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

  /// ================= OFFERS =================
  Widget _offersSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Offers & Rewards",
          style: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 12),
        ImageAdsBanner(adsImages: adsImages),
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
  String? bgImage, // 👈 optional image
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
    child: Stack(
      children: [
        /// 🔹 Background Image (Bottom Right)
        if (bgImage != null)
          Positioned(
            bottom: -10,
            right: -10,
            child: Opacity(
              opacity: 0.18, // watermark effect
              child: Image.asset(
                bgImage,
                height: 80,
                fit: BoxFit.contain,
              ),
            ),
          ),

        /// 🔹 Main Content
        Padding(
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
        ),
      ],
    ),
  );
}


/// ================= IMAGE ADS =================
class ImageAdsBanner extends StatelessWidget {
  final List<String> adsImages;

  const ImageAdsBanner({super.key, required this.adsImages});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(22),
      child: Stack(
        children: [
          Image.network(
            adsImages.first,
            height: 170,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Container(
            height: 170,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.black.withOpacity(0.6),
                  Colors.transparent,
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: Text(
              "Complete more trips & earn bonus 🚀",
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
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
