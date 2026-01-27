import 'dart:async';
import 'package:cab_bandhu/core/constants/color_constants.dart';
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
      backgroundColor: const Color(0xFFF9FAFB), // 🌤 LIGHT BACKGROUND
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Trip Completed",
          style: TextStyle(color: Colors.black87),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            /// ✅ CHECK ICON
            const Icon(
              Icons.check_circle,
              size: 80,
              color: AppColors.ridePrimary,
            ).animate().fadeIn().slideY(begin: -0.2),

            const SizedBox(height: 10),

            /// ✅ COMPLETED TEXT
            const Text(
              "Trip Successfully Completed",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ).animate().fadeIn().slideY(begin: -0.1),

            const SizedBox(height: 30),

            /// 💰 FARE DETAILS CARD
            _card(
              child: Column(
                children: [
                  _fareRow("Base Fare", baseFare),
                  _fareRow("Distance Fare", distanceFare),
                  _fareRow("Time Fare", timeFare),
                  const Divider(),
                  _fareRow("TOTAL", total, bold: true),
                ],
              ),
            ).animate().fadeIn().slideY(begin: 0.1),

            const SizedBox(height: 24),

            /// 💳 PAYMENT STATUS
            _paymentStatusCard()
                .animate()
                .fadeIn()
                .slideY(begin: 0.2),

            const SizedBox(height: 24),

            Align(
              alignment: Alignment.centerLeft,
              child: const Text(
                "Offers & Rewards",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ).animate().fadeIn(),

            const SizedBox(height: 10),

            /// 📢 ADS BANNER
            ImageAdsBanner(
              height: h * 0.18,
              adsImages: const [
                "https://images.unsplash.com/photo-1523275335684-37898b6baf30",
              ],
            ).animate().fadeIn().scale(begin: const Offset(0.95, 0.95)),

            const Spacer(),

            /// 🚦 RATE BUTTON
            SizedBox(
              width: double.infinity,
              height: 52,
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
                    _slideRoute(const RatePassengerScreen()),
                  );
                },
                child: const Text(
                  "Rate User",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ).animate().fadeIn().slideY(begin: 0.3),
          ],
        ),
      ),
    ).animate().fadeIn().slideY(begin: 0.1);
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
              color: Colors.black87,
            ),
          ),
          Text(
            "₹${value.toStringAsFixed(0)}",
            style: TextStyle(
              fontSize: bold ? 16 : 14,
              fontWeight: bold ? FontWeight.bold : FontWeight.normal,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  /// 🧱 CARD
  Widget _card({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }

  /// 💳 PAYMENT CARD
  Widget _paymentStatusCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.green.shade300),
      ),
      child: Row(
        children: const [
          Icon(Icons.payments, color: Colors.green),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              "Payment Received (Cash)",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// ================= IMAGE ADS BANNER ================
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

/// 🌟 PAGE TRANSITION
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
