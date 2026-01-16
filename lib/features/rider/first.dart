import 'dart:async';
import 'package:cab_bandhu/features/rider/second.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'custom_app_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isOnline = true;
  bool hasRideRequest = true;

  final List<String> adsImages = [
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSSXIXtIUUQHSI5SWYvD9a830k84jiX23Yplw&s",
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
      Future.delayed(Duration.zero, () {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => AlertDialog(
            backgroundColor: Colors.grey[900],
            title: const Text(
              "⚠️ Important Instructions",
              style: TextStyle(color: Colors.white),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text("• Location access is required",
                    style: TextStyle(color: Colors.white70)),
                Text("• Background tracking used during trips",
                    style: TextStyle(color: Colors.white70)),
                Text("• Follow pickup & drop rules",
                    style: TextStyle(color: Colors.white70)),
                SizedBox(height: 10),
                Text(
                  "🔗 Terms & Conditions",
                  style: TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ],
            ),
            actions: [
              ElevatedButton(
                onPressed: () async {
                  await prefs.setBool('caution_shown', true);
                  Navigator.pop(context);
                },
                child: const Text("Agree & Continue"),
              )
            ],
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: CustomHomeAppBar(
        onDutyChanged: (value) {
          setState(() {
            isOnline = value;
            hasRideRequest = value;
          });
        },
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Today's performance",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.2),

              const SizedBox(height: 10),

              Row(
                children: [
                  Expanded(
                    child: _statCard(
                      title: "Today Earnings",
                      value: "₹ 1,250",
                      icon: Icons.account_balance_wallet,
                      color: const Color(0xff8BE98E),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _statCard(
                      title: "Trips",
                      value: "8",
                      icon: Icons.route,
                      color: const Color(0xffF7C846),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              if (isOnline && hasRideRequest) _incomingRideCard(),

              const SizedBox(height: 20),

              const Text(
                "Offers & Rewards",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 10),

              ImageAdsBanner(adsImages: adsImages),

              const SizedBox(height: 12),

              const Text(
                "Porter Driver Mode",
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.white70,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// ================= INCOMING RIDE CARD =================
  Widget _incomingRideCard() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Incoming Ride",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  "00:25",
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          Row(
            children: const [
              Icon(Icons.notifications_active,
                  color: Colors.green, size: 18),
              SizedBox(width: 8),
              Text(
                "New Ride Request",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          _locationRow(
            icon: Icons.radio_button_checked,
            value: "Bhopal Railway Station",
            color: Colors.green,
          ),

          const SizedBox(height: 10),

          _locationRow(
            icon: Icons.location_on,
            value: "MP Nagar Zone 2",
            color: Colors.redAccent,
          ),

          const Divider(height: 28, color: Colors.black12),

          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _InfoTile(title: "Distance", value: "6.2 km"),
              _InfoTile(title: "Fare", value: "₹320"),
              _InfoTile(title: "Payment", value: "Cash"),
            ],
          ),

          const SizedBox(height: 20),

          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.red,
                    side: const BorderSide(color: Colors.red),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding:
                    const EdgeInsets.symmetric(vertical: 14),
                  ),
                  onPressed: () =>
                      setState(() => hasRideRequest = false),
                  child: const Text("Reject"),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding:
                    const EdgeInsets.symmetric(vertical: 14),
                  ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_)=> DriverRideAcceptedScreen()));
                  },
                  child: const Text(
                    "Accept Ride",
                    style: TextStyle(color: Colors.white),
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
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Colors.black,
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
  required Color color,
}) {
  return Container(
    height: 120,
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(18),
      boxShadow: [
        BoxShadow(
          color: color.withOpacity(0.5),
          blurRadius: 10,
          offset: const Offset(0, 5),
        ),
      ],
    ),
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: Colors.black, size: 26),
        const Spacer(),
        Text(
          value,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          title,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ],
    ),
  );
}

/// ================= IMAGE ADS =================
class ImageAdsBanner extends StatelessWidget {
  final List<String> adsImages;
  final double height;

  const ImageAdsBanner({
    super.key,
    required this.adsImages,
    this.height = 170,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(adsImages.first, fit: BoxFit.cover),
            Container(
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
            const Positioned(
              bottom: 12,
              left: 0,
              right: 0,
              child: Text(
                "Complete more trips & earn bonus 🚀",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
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
        Text(
          title,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.black54,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
