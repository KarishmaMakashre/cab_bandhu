import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as gmaps;
import 'package:go_router/go_router.dart';

import '../rider/five.dart';

class PickupVerificationMapScreen extends StatefulWidget {
  const PickupVerificationMapScreen({super.key});

  @override
  State<PickupVerificationMapScreen> createState() =>
      _PickupVerificationMapScreenState();
}

class _PickupVerificationMapScreenState
    extends State<PickupVerificationMapScreen>
    with SingleTickerProviderStateMixin {
  gmaps.GoogleMapController? _mapController;
  final TextEditingController _otpController = TextEditingController();

  final gmaps.LatLng pickupLatLng = const gmaps.LatLng(22.719568, 75.857727);
  final String pickupAddress = "Vijay Nagar Square, Indore";
  final String correctOtp = "1234";
  bool isOtpVerified = false;

  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController =
    AnimationController(vsync: this, duration: const Duration(milliseconds: 800))
      ..forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 800),
      minTextAdapt: true,
      builder: (_, __) => Scaffold(
        body: Stack(
          children: [
            /// 🌍 GOOGLE MAP
            Positioned.fill(
              child: gmaps.GoogleMap(
                initialCameraPosition: gmaps.CameraPosition(
                  target: pickupLatLng,
                  zoom: 16,
                ),
                onMapCreated: (c) => _mapController = c,
                markers: {
                  gmaps.Marker(
                    markerId: const gmaps.MarkerId('pickup'),
                    position: pickupLatLng,
                  ),
                },
                myLocationEnabled: true,
                zoomControlsEnabled: false,
              ),
            ),

            /// 🔙 BACK BUTTON
            SafeArea(
              child: Padding(
                padding: EdgeInsets.all(12.w),
                child: CircleAvatar(
                  backgroundColor: Colors.black54,
                  child: IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.white, size: 20.sp),
                    onPressed: () => context.pop(),
                  ),
                ),
              ),
            ),

            /// ⬆️ BOTTOM SHEET
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 0.58.sh,
                decoration: BoxDecoration(
                  borderRadius:
                  BorderRadius.vertical(top: Radius.circular(24.r)),
                  image: const DecorationImage(
                    image: AssetImage('assets/images/backgroundImg.jpeg'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.78),
                    borderRadius:
                    BorderRadius.vertical(top: Radius.circular(24.r)),
                  ),
                  padding: EdgeInsets.fromLTRB(20.w, 24.h, 20.w, 20.h),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _animated(_pickupAddressWidget(), 0),
                        16.verticalSpace,
                        _animated(_ownerDetails(), 100),
                        16.verticalSpace,
                        _animated(_receiverDetails(), 200),
                        16.verticalSpace,
                        _animated(_goodsSummary(), 300),
                        16.verticalSpace,
                        _animated(_otpInput(), 400),
                        24.verticalSpace,
                        _animated(_startRideButton(), 500),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// ✨ ANIMATION
  Widget _animated(Widget child, int delay) {
    final curve = CurvedAnimation(
      parent: _animationController,
      curve: Interval(delay / 1000, 1, curve: Curves.easeOut),
    );

    return FadeTransition(
      opacity: curve,
      child: SlideTransition(
        position:
        Tween(begin: const Offset(0, 0.1), end: Offset.zero).animate(curve),
        child: child,
      ),
    );
  }

  /// 📍 PICKUP ADDRESS
  Widget _pickupAddressWidget() {
    return Row(
      children: [
        Icon(Icons.location_on, color: Colors.green, size: 22.sp),
        8.horizontalSpace,
        Expanded(
          child: Text(
            pickupAddress,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: Colors.black
            ),
          ),
        ),
      ],
    );
  }

  /// 📦 COMMON CARD
  Widget _card({required Widget child, required double height}) {
    return SizedBox(
      height: height,
      width: double.infinity, // 🔥 WIDTH FULL
      child: Container(
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14.r),
          boxShadow: [
            BoxShadow(color: Colors.black12, blurRadius: 6.r),
          ],
        ),
        child: child,
      ),
    );
  }

  /// 👤 OWNER
  Widget _ownerDetails() {
    return _card(
      height: 120.h,
      child: Row(
        children: [
          CircleAvatar(
            radius: 22.r,
            backgroundColor: Colors.green,
            child: Icon(Icons.person, color: Colors.white, size: 22.sp),
          ),
          12.horizontalSpace,
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Rahul Sharma',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.sp, color: Colors.black)),
              Text('Goods Owner',
                  style: TextStyle(fontSize: 13.sp, color: Colors.black54)),
            ],
          ),
        ],
      ),
    );
  }

  /// 🏠 RECEIVER (BIGGER)
  Widget _receiverDetails() {
    return _card(
      height: 140.h, // 🔥 pehle 145.h tha → ab zyada height
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Receiver Details',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15.sp, // thoda bada
              color: Colors.black
            ),
          ),
          12.verticalSpace, // spacing increased
          Text('Amit Verma', style: TextStyle(fontSize: 14.sp, color: Colors.black45)),
          6.verticalSpace,
          Text(
            'MP Nagar, Bhopal',
            style: TextStyle(fontSize: 13.sp, color: Colors.black54),
          ),
          6.verticalSpace,
          Text('+91 9876543210', style: TextStyle(fontSize: 13.sp,color: Colors.black45)),
        ],
      ),
    );
  }

  /// 🚚 GOODS (BIGGER)
  Widget _goodsSummary() {
    return _card(
      height: 120.h,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Goods Summary',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp,color: Colors.black)),
          8.verticalSpace,
          Text('• Bed, Table, Chairs', style: TextStyle(fontSize: 13.sp,color: Colors.black45)),
          Text('• Weight: 120 kg', style: TextStyle(fontSize: 13.sp,color: Colors.black45)),
        ],
      ),
    );
  }

  /// 🔐 OTP
  Widget _otpInput() {
    return _card(
      height: 130.h,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Enter Pickup OTP',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14.sp,
              color: Colors.black,
            ),
          ),
          8.verticalSpace,
          TextField(
            controller: _otpController,
            maxLength: 4,
            keyboardType: TextInputType.number,

            // ✅ Typed OTP text color
            style: TextStyle(
              fontSize: 16.sp,
              color: Colors.black,
              letterSpacing: 6, // OTP look 🔥 (optional)
              fontWeight: FontWeight.w600,
            ),

            // ✅ Cursor black
            cursorColor: Colors.black,

            // ✅ Selection (blue/purple hatake black-grey)
            selectionControls: materialTextSelectionControls,

            decoration: InputDecoration(
              counterText: '',
              hintText: '4 Digit OTP',
              hintStyle: TextStyle(color: Colors.black38),
              filled: true,
              fillColor: Colors.grey.shade100,

              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: const BorderSide(color: Colors.black26),
              ),

              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide:
                const BorderSide(color: Colors.black, width: 1.5),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 🚖 START RIDE
  Widget _startRideButton() {
    return SizedBox(
      height: 52.h,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isOtpVerified ? _startRide : null, // ✅ only when 4 digit OTP

        style: ElevatedButton.styleFrom(
          backgroundColor:
          isOtpVerified ? Colors.green : Colors.grey.shade400,
          foregroundColor:
          isOtpVerified ? Colors.white : Colors.black54,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14.r),
          ),
        ),

        child: Text(
          'START RIDE',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  void _verifyOtp() {
    setState(() {
      isOtpVerified = _otpController.text == correctOtp;
    });
  }

  void _startRide() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const DriverTripInProgressScreen(),
      ),
    );
  }
}
