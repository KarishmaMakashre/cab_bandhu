import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'nine.dart'; // RatePassengerScreen

class DriverTripCompletedScreen extends StatelessWidget {
  const DriverTripCompletedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double baseFare = 80;
    final double distanceFare = 220;
    final double timeFare = 40;
    final double total = baseFare + distanceFare + timeFare;
    final h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFF121212), // 🔥 DARK BACKGROUND
      appBar: AppBar(
        backgroundColor: const Color(0xFF121212),
        elevation: 0,
        title: const Text(
          "Trip Completed",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            /// ✅ CHECK ICON
            const Icon(Icons.check_circle, size: 80, color: Colors.green)
                .animate()
                .fadeIn(duration: 500.ms)
                .slideY(begin: -0.2),

            const SizedBox(height: 10),

            /// ✅ COMPLETED TEXT
            const Text(
              "Trip Successfully Completed",
              style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
            ).animate(delay: 100.ms)
                .fadeIn()
                .slideY(begin: -0.1),

            const SizedBox(height: 30),

            /// 💰 FARE DETAILS
            _fareRow("Base Fare", baseFare)
                .animate()
                .fadeIn(delay: 200.ms)
                .slideX(begin: -0.2),
            _fareRow("Distance Fare", distanceFare)
                .animate()
                .fadeIn(delay: 300.ms)
                .slideX(begin: -0.2),
            _fareRow("Time Fare", timeFare)
                .animate()
                .fadeIn(delay: 400.ms)
                .slideX(begin: -0.2),
            const Divider(color: Colors.white54),
            _fareRow("TOTAL", total, bold: true)
                .animate()
                .fadeIn(delay: 500.ms)
                .slideX(begin: -0.2),

            const SizedBox(height: 30),

            /// 💳 PAYMENT STATUS
            _paymentStatusCard()
                .animate()
                .fadeIn(delay: 600.ms)
                .slideY(begin: 0.2),

            const SizedBox(height: 20),

            Align(
              alignment: Alignment.centerLeft,
              child: const Text(
                "Offers & Rewards",
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              ),
            ).animate(delay: 700.ms).fadeIn(),

            const SizedBox(height: 10),

            /// 📢 ADS BANNER
            ImageAdsBanner(
              height: h * 0.18,
              adsImages: const [
                "https://images.unsplash.com/photo-1523275335684-37898b6baf30",
              ],
            )
                .animate(delay: 800.ms)
                .fadeIn()
                .scale(begin: const Offset(0.95, 0.95)),

            const Spacer(),

            /// 🚦 RATE BUTTON
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.greenAccent,
                minimumSize: const Size(double.infinity, 50),
              ),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  _slideRoute(const RatePassengerScreen()),
                );
              },
              child: const Text(
                "Rate User",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ).animate(delay: 900.ms).fadeIn().slideY(begin: 0.3),
          ],
        ),
      ),
    )
    // 🌟 SCREEN ENTER ANIMATION
        .animate()
        .fadeIn(duration: 400.ms)
        .slideY(begin: 0.1);
  }

  /// 💰 FARE ROW
  Widget _fareRow(String label, double value, {bool bold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
                fontSize: bold ? 16 : 14,
                fontWeight: bold ? FontWeight.bold : FontWeight.normal,
                color: Colors.white),
          ),
          Text(
            "₹${value.toStringAsFixed(0)}",
            style: TextStyle(
                fontSize: bold ? 16 : 14,
                fontWeight: bold ? FontWeight.bold : FontWeight.normal,
                color: Colors.white),
          ),
        ],
      ),
    );
  }

  /// 💳 PAYMENT CARD
  Widget _paymentStatusCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.green.shade900,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.greenAccent),
      ),
      child: Row(
        children: const [
          Icon(Icons.payments, color: Colors.greenAccent),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              "Payment Received (Cash)",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.greenAccent),
            ),
          ),
        ],
      ),
    );
  }
}

/// ================= IMAGE ADS BANNER =================

class ImageAdsBanner extends StatefulWidget {
  final List<String> adsImages;
  final double height;
  final Duration autoScrollDuration;

  const ImageAdsBanner({
    super.key,
    required this.adsImages,
    required this.height,
    this.autoScrollDuration = const Duration(seconds: 2),
  });

  @override
  State<ImageAdsBanner> createState() => _ImageAdsBannerState();
}

class _ImageAdsBannerState extends State<ImageAdsBanner> {
  late PageController _controller;
  Timer? _timer;
  int _index = 0;

  @override
  void initState() {
    super.initState();
    _controller = PageController();

    _timer = Timer.periodic(widget.autoScrollDuration, (_) {
      if (!_controller.hasClients) return;
      _index = (_index + 1) % widget.adsImages.length;
      _controller.animateToPage(
        _index,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: PageView.builder(
        controller: _controller,
        itemCount: widget.adsImages.length,
        itemBuilder: (_, i) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Image.network(
              widget.adsImages[i],
              fit: BoxFit.cover,
            ),
          );
        },
      ),
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
