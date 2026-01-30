import 'dart:async';
import 'package:cab_bandhu/core/constants/color_constants.dart';
import 'package:cab_bandhu/features/rider/third.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'eight.dart';

class DriverRideAcceptedScreen extends StatelessWidget {
  const DriverRideAcceptedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          iconTheme: const IconThemeData(color: Colors.black),
          title: Text(
            "Ride Accepted",
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
        ),
        body: Stack(
          children: [
            /// 🌄 Background
            Positioned.fill(
              child: Image.asset(
                "assets/images/backgroundImg.jpeg",
                fit: BoxFit.cover,
              ),
            ),

            /// 🌫 Overlay
            Positioned.fill(
              child: Container(
                color: Colors.white.withOpacity(0.88),
              ),
            ),

            /// 🧱 Content
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                children: [
                  _card(child: _passengerRow())
                      .animate()
                      .fadeIn(duration: 400.ms)
                      .slideY(begin: -0.2),

                  SizedBox(height: 16.h),

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
                  ).animate(delay: 150.ms).fadeIn().slideX(begin: -0.2),

                  SizedBox(height: 16.h),

                  _card(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _tripInfo("Distance", "8.4 km"),
                        _tripInfo("Fare", "₹320"),
                        _tripInfo("Payment", "Cash"),
                      ],
                    ),
                  ).animate(delay: 300.ms).fadeIn().slideX(begin: 0.2),

                  SizedBox(height: 20.h),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Offers & Rewards",
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.black87,
                      ),
                    ),
                  ).animate().fadeIn(delay: 400.ms),

                  SizedBox(height: 10.h),

                  ImageAdsBanner(
                    height: h * 0.18,
                    adsImages: const [
                      "https://images.unsplash.com/photo-1607082352121-fa243f3dde32",
                    ],
                  ).animate().fadeIn(delay: 500.ms).scale(),

                  const Spacer(),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.ridebtn,
                      minimumSize: Size(double.infinity, 54.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      elevation: 4,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        _slideRoute(const DriverNavigatePickupScreen()),
                      );
                    },
                    child: Text(
                      "Navigate to Pickup",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ).animate().fadeIn(delay: 650.ms).slideY(begin: 0.3),
                ],
              ),
            ),
          ],
        ),
      ).animate().fadeIn(duration: 350.ms).slideY(begin: 0.1),
    );
  }

  /// 🚕 Passenger
  Widget _passengerRow() {
    return Row(
      children: [
        CircleAvatar(
          radius: 26.r,
          backgroundImage: const NetworkImage(
            "https://i.pravatar.cc/150?img=3",
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Rahul Sharma",
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                "⭐ 4.8 • 52 trips",
                style: TextStyle(
                  fontSize: 13.sp,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
        Icon(Icons.call, color: Colors.green, size: 22.sp),
        SizedBox(width: 10.w),
        Icon(Icons.chat, color: Colors.blue, size: 22.sp),
      ],
    );
  }

  /// 🔲 Card
  Widget _card({required Widget child}) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18.r),
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

  /// 📍 Location
  Widget _locationRow({
    required IconData icon,
    required Color color,
    required String title,
    required String value,
  }) {
    return Row(
      children: [
        Icon(icon, color: color, size: 18.sp),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.black54,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                value,
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _routeDivider() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: const Divider(),
    );
  }

  Widget _tripInfo(String title, String value) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 12.sp, color: Colors.black54),
        ),
        SizedBox(height: 6.h),
        Text(
          value,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

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

}
