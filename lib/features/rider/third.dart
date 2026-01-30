import 'package:cab_bandhu/core/constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'four.dart'; // DriverPickupVerificationScreen

class DriverNavigatePickupScreen extends StatelessWidget {
  const DriverNavigatePickupScreen({super.key});

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
            "Navigate to Pickup",
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

            /// 🌫 MAIN OVERLAY
            Positioned.fill(
              child: Container(
                color: Colors.white.withOpacity(0.85),
              ),
            ),

            /// 🧱 CONTENT
            Column(
              children: [
                /// 🗺 MAP VIEW
                Expanded(
                  child: Container(
                    color: Colors.grey.shade300,
                    child: Center(
                      child: Text(
                        "Google Map View",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                  )
                      .animate()
                      .fadeIn(duration: 500.ms)
                      .slideY(begin: -0.1),
                ),

                /// 🚕 BOTTOM PANEL WITH IMAGE BG
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(22.r),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.12),
                        blurRadius: 18,
                        offset: const Offset(0, -6),
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      /// 🖼 Image BG
                      Positioned.fill(
                        child: ClipRRect(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(22.r),
                          ),
                          child: Image.asset(
                            "assets/images/backgroundImg.jpeg",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),

                      /// 🌫 White overlay for readability
                      Positioned.fill(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.92),
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(22.r),
                            ),
                          ),
                        ),
                      ),

                      /// 📦 CONTENT
                      Padding(
                        padding: EdgeInsets.all(16.w),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            /// 👤 Passenger info
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 24.r,
                                  backgroundImage: const NetworkImage(
                                    "https://i.pravatar.cc/150?img=3",
                                  ),
                                ),
                                SizedBox(width: 12.w),

                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
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
                                        "Pickup: Airport Road",
                                        style: TextStyle(
                                          fontSize: 13.sp,
                                          color: Colors.black54,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                Icon(Icons.call,
                                    color: Colors.green, size: 22.sp),
                                SizedBox(width: 10.w),
                                Icon(Icons.chat,
                                    color: Colors.blue, size: 22.sp),
                              ],
                            )
                                .animate()
                                .fadeIn(duration: 400.ms)
                                .slideX(begin: -0.2),

                            SizedBox(height: 16.h),

                            /// 🚦 ARRIVED BUTTON
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.ridePrimary,
                                minimumSize:
                                Size(double.infinity, 54.h),
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(16.r),
                                ),
                                elevation: 4,
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  _slideRoute(
                                    const DriverPickupVerificationScreen(),
                                  ),
                                );
                              },
                              child: Text(
                                "Arrived at Pickup",
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                            )
                                .animate()
                                .fadeIn(duration: 500.ms)
                                .slideY(begin: 0.2),

                            SizedBox(height: 8.h),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
                    .animate()
                    .fadeIn(duration: 500.ms)
                    .slideY(begin: 0.1),
              ],
            ),
          ],
        ),
      ).animate().fadeIn(duration: 350.ms).slideY(begin: 0.1),
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
