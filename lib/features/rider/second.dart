import 'dart:async';
import 'package:cab_bandhu/core/constants/color_constants.dart';
import 'package:cab_bandhu/features/rider/third.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'eight.dart';

class DriverRideAcceptedScreen extends StatelessWidget {
  const DriverRideAcceptedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xffF6F7FB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Ride Accepted",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            /// 🚕 PASSENGER CARD
            _card(child: _passengerRow())
                .animate()
                .fadeIn(duration: 400.ms)
                .slideY(begin: -0.2),

            const SizedBox(height: 16),

            /// 📍 ROUTE CARD
            _card(
              child: Column(
                children: [
                  _locationRow(
                    icon: Icons.radio_button_checked,
                    color: Colors.green,
                    title: "Pickup",
                    value: "Airport Road, Bhopal",
                  ),
                  _routeDivider(),
                  _locationRow(
                    icon: Icons.location_on,
                    color: Colors.redAccent,
                    title: "Drop",
                    value: "MP Nagar Zone 2",
                  ),
                ],
              ),
            )
                .animate(delay: 150.ms)
                .fadeIn()
                .slideX(begin: -0.2),

            const SizedBox(height: 16),

            /// 💰 TRIP DETAILS
            _card(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _tripInfo("Distance", "8.4 km"),
                  _tripInfo("Fare", "₹320"),
                  _tripInfo("Payment", "Cash"),
                ],
              ),
            )
                .animate(delay: 300.ms)
                .fadeIn()
                .slideX(begin: 0.2),

            const SizedBox(height: 20),

            Align(
              alignment: Alignment.centerLeft,
              child: const Text(
                "Offers & Rewards",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ).animate().fadeIn(delay: 400.ms),

            const SizedBox(height: 10),

            /// 📢 ADS
            ImageAdsBanner(
              height: h * 0.18,
              adsImages: const [
                "https://images.unsplash.com/photo-1607082352121-fa243f3dde32",
              ],
            )
                .animate()
                .fadeIn(delay: 500.ms)
                .scale(begin: const Offset(0.95, 0.95)),

            const Spacer(),

            /// 🚦 NAVIGATE BUTTON
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.ridePrimary,
                minimumSize: const Size(double.infinity, 54),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 4,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  _slideRoute(const DriverNavigatePickupScreen()),
                );
              },
              child: const Text(
                "Navigate to Pickup",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            )
                .animate()
                .fadeIn(delay: 650.ms)
                .slideY(begin: 0.3),
          ],
        ),
      ),
    )
        .animate()
        .fadeIn(duration: 350.ms)
        .slideY(begin: 0.1);
  }

  /// 🚕 PASSENGER ROW
  Widget _passengerRow() {
    return Row(
      children: [
        const CircleAvatar(
          radius: 26,
          backgroundImage: NetworkImage(
            "https://i.pravatar.cc/150?img=3",
          ),
        ),
        const SizedBox(width: 12),
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
        IconButton(
          icon: const Icon(Icons.call, color: Colors.green),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.chat, color: Colors.blue),
          onPressed: () {},
        ),
      ],
    );
  }

  /// 🔲 CARD
  Widget _card({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(16),
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

  /// 📍 LOCATION ROW
  Widget _locationRow({
    required IconData icon,
    required Color color,
    required String title,
    required String value,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: color, size: 18),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _routeDivider() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          SizedBox(width: 10),
          SizedBox(
            height: 26,
            child: VerticalDivider(thickness: 1),
          ),
        ],
      ),
    );
  }

  Widget _tripInfo(String title, String value) {
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
