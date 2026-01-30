import 'package:cab_bandhu/core/constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
        SnackBar(
          content: Text(
            "Incorrect OTP. Please verify with passenger.",
            style: TextStyle(fontSize: 14.sp),
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
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
            "Pickup Verification",
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
        ),
        body: Stack(
          children: [
            /// 🌄 BACKGROUND IMAGE
            Positioned.fill(
              child: Image.asset(
                "assets/images/backgroundImg.jpeg",
                fit: BoxFit.cover,
              ),
            ),

            /// 🌫 OVERLAY
            Positioned.fill(
              child: Container(
                color: Colors.white.withOpacity(0.85),
              ),
            ),

            /// 🧱 CONTENT
            Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(16.w),
                    child: Column(
                      children: [
                        _card(
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 28.r,
                                backgroundImage: const NetworkImage(
                                  "https://i.pravatar.cc/150?img=3",
                                ),
                              ),
                              SizedBox(width: 14.w),
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
                              Column(
                                children: [
                                  Icon(Icons.verified_user,
                                      color: Colors.green, size: 20.sp),
                                  SizedBox(height: 4.h),
                                  Text(
                                    "Verified",
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      color: Colors.green,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ).animate().fadeIn().slideX(begin: -0.2),

                        SizedBox(height: 16.h),

                        _card(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(Icons.location_on,
                                  color: Colors.green, size: 20.sp),
                              SizedBox(width: 10.w),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Pickup Location",
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        color: Colors.black54,
                                      ),
                                    ),
                                    SizedBox(height: 4.h),
                                    Text(
                                      "Airport Road, Bhopal (Terminal 2)",
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
                          ),
                        ).animate().fadeIn().slideX(begin: 0.2),

                        SizedBox(height: 16.h),

                        _card(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: const [
                              _TripStat(title: "Distance", value: "8.4 km"),
                              _TripStat(title: "Fare", value: "₹320"),
                              _TripStat(title: "Payment", value: "Cash"),
                            ],
                          ),
                        ).animate().fadeIn().slideY(begin: 0.1),

                        SizedBox(height: 30.h),

                        Text(
                          "Enter Trip OTP",
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        ),

                        SizedBox(height: 6.h),

                        Text(
                          "Ask passenger for the OTP to start trip",
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: Colors.black54,
                          ),
                        ),

                        SizedBox(height: 24.h),

                        SizedBox(
                          width: 200.w,
                          child: TextField(
                            controller: otpController,
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            maxLength: 4,
                            cursorColor: Colors.black, // ✅ BLACK CURSOR
                            style: TextStyle(
                              fontSize: 26.sp,
                              letterSpacing: 14.w,
                              fontWeight: FontWeight.bold,
                              color: Colors.black, // ✅ BLACK NUMBERS
                            ),
                            decoration: InputDecoration(
                              counterText: "",
                              filled: true,
                              fillColor: Colors.white,
                              hintText: "• • • •",
                              hintStyle: TextStyle(
                                color: Colors.black38,
                                fontSize: 22.sp,
                              ),

                              /// 🔲 DEFAULT BORDER
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16.r),
                                borderSide: const BorderSide(
                                  color: Colors.black, // ✅ BLACK BORDER
                                  width: 1.4,
                                ),
                              ),

                              /// 🔲 FOCUSED BORDER
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16.r),
                                borderSide: const BorderSide(
                                  color: Colors.black, // ✅ BLACK BORDER
                                  width: 2,
                                ),
                              ),

                              /// 🔲 ERROR BORDER (optional)
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16.r),
                                borderSide: const BorderSide(
                                  color: Colors.red,
                                  width: 1.5,
                                ),
                              ),
                            ),
                          ),
                        ),


                        SizedBox(height: 12.h),

                        Container(
                          padding: EdgeInsets.all(12.w),
                          decoration: BoxDecoration(
                            color: Colors.orange.withOpacity(0.08),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.security,
                                  color: Colors.orange, size: 20.sp),
                              SizedBox(width: 10.w),
                              Expanded(
                                child: Text(
                                  "For your safety, never start the trip without OTP verification.",
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 20.h),

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
                        ),
                      ],
                    ),
                  ),
                ),

                Container(
                  padding: EdgeInsets.all(16.w),
                  color: Colors.white,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.ridebtn,
                      minimumSize: Size(double.infinity, 54.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                    ),
                    onPressed: _verifyOtp,
                    child: Text(
                      "Verify OTP & Start Trip",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
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

  Widget _card({required Widget child}) {
    return Container(
      padding: EdgeInsets.all(16.w),
      margin: EdgeInsets.symmetric(vertical: 6.h),
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
      borderRadius: BorderRadius.circular(40.r),
      child: Column(
        children: [
          CircleAvatar(
            radius: 26.r,
            backgroundColor: color.withOpacity(0.15),
            child: Icon(icon, color: color, size: 28.sp),
          ),
          SizedBox(height: 6.h),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w700,
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
          style: TextStyle(fontSize: 12.sp, color: Colors.black54),
        ),
        SizedBox(height: 6.h),
        Text(
          value,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
            color: Colors.black45
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
