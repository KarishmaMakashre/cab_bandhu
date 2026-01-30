import 'package:cab_bandhu/core/constants/color_constants.dart';
import 'package:cab_bandhu/features/rider/six.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DriverTripInProgressScreen extends StatelessWidget {
  const DriverTripInProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.black.withOpacity(0.5),
          elevation: 0,
          centerTitle: true,
          iconTheme: const IconThemeData(color: Colors.white),
          title: Text(
            "Trip In Progress",
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
        body: Stack(
          children: [

            Column(
              children: [
                /// 🗺️ MAP PLACEHOLDER
                Expanded(
                  child: Center(
                    child: Text(
                      "LIVE NAVIGATION MAP",
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.white70,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                /// 🔽 BOTTOM PANEL (WITH BG IMAGE)
                _BottomTripPanel(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// 🔽 BOTTOM PANEL
class _BottomTripPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.vertical(top: Radius.circular(22.r)),
      child: Stack(
        children: [
          /// 🌄 BG IMAGE (ONLY BOTTOM)
          Positioned.fill(
            child: Image.asset(
              "assets/images/backgroundImg.jpeg",
              fit: BoxFit.cover,
            ),
          ),

          /// 🌫 WHITE OVERLAY
          Positioned.fill(
            child: Container(
              color: Colors.white.withOpacity(0.90),
            ),
          ),

          /// 🧱 CONTENT
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                /// 👤 PASSENGER INFO
                Row(
                  children: [
                    CircleAvatar(
                      radius: 22.r,
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
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            "⭐ 4.8 rating",
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),

                    Icon(Icons.call, color: Colors.green),
                    SizedBox(width: 10.w),
                    Icon(Icons.chat, color: Colors.blue),
                  ],
                ),

                SizedBox(height: 14.h),

                _routeRow(
                  icon: Icons.location_on,
                  color: Colors.green,
                  label: "Pickup",
                  value: "Airport Road, Bhopal",
                ),

                SizedBox(height: 8.h),

                _routeRow(
                  icon: Icons.flag,
                  color: Colors.red,
                  label: "Drop",
                  value: "MP Nagar Zone 2",
                ),

                SizedBox(height: 16.h),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const [
                    _TripStat(title: "Distance", value: "5.2 km"),
                    _TripStat(title: "Time", value: "18 min"),
                    _TripStat(title: "ETA", value: "7 min"),
                  ],
                ),

                SizedBox(height: 20.h),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.ridebtn,
                    minimumSize: Size(double.infinity, 54.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const DriverTripStartedScreen(),
                      ),
                    );
                  },
                  child: Text(
                    "End Trip",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// 📍 ROUTE ROW
Widget _routeRow({
  required IconData icon,
  required Color color,
  required String label,
  required String value,
}) {
  return Row(
    children: [
      Icon(icon, color: color, size: 18.sp),
      SizedBox(width: 10.w),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(fontSize: 12.sp, color: Colors.black54),
            ),
            SizedBox(height: 2.h),
            Text(
              value,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

/// 📊 STAT
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
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
