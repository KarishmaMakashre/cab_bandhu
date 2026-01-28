import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as gmaps;
import 'package:go_router/go_router.dart';
import '../../../../core/constants/color_constants.dart';
import '../../rider/five.dart';

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
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          /// 🌍 Google Map
          Positioned.fill(
            child: gmaps.GoogleMap(
              initialCameraPosition: gmaps.CameraPosition(
                target: pickupLatLng,
                zoom: 16,
              ),
              onMapCreated: (controller) => _mapController = controller,
              markers: {
                gmaps.Marker(
                  markerId: const gmaps.MarkerId('pickup'),
                  position: pickupLatLng,
                  icon: gmaps.BitmapDescriptor.defaultMarkerWithHue(
                    gmaps.BitmapDescriptor.hueGreen,
                  ),
                ),
              },
              myLocationEnabled: true,
              zoomControlsEnabled: false,
            ),
          ),

          /// 🔙 Back Button
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: CircleAvatar(
                backgroundColor: Colors.white,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: (){
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
          ),

          /// ⬆️ Bottom Sheet
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.58,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                boxShadow: [
                  BoxShadow(color: Colors.black12, blurRadius: 12)
                ],
              ),
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _animatedFadeSlide(_pickupAddressWidget(), delay: 0),
                    const SizedBox(height: 16),
                    _animatedFadeSlide(_ownerDetails(), delay: 100),
                    const SizedBox(height: 16),
                    _animatedFadeSlide(_otpInput(), delay: 400),
                    const SizedBox(height: 24),
                    _animatedFadeSlide(_startRideButton(), delay: 500),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 🔥 Animation Wrapper
  Widget _animatedFadeSlide(Widget child, {int delay = 0}) {
    return FadeTransition(
      opacity: CurvedAnimation(
        parent: _animationController,
        curve: Interval(delay / 1000, 1.0, curve: Curves.easeOut),
      ),
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 0.1),
          end: Offset.zero,
        ).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Interval(delay / 1000, 1.0, curve: Curves.easeOut),
          ),
        ),
        child: child,
      ),
    );
  }

  Widget _pickupAddressWidget() {
    return Row(
      children: [
        const Icon(Icons.location_on, color: Colors.green),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            pickupAddress,
            style: const TextStyle(
                fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }

  Widget _ownerDetails() {
    return _card(
      child: Row(
        children: [
          const CircleAvatar(
            radius: 24,
            backgroundColor: Colors.green,
            child: Icon(Icons.person, color: Colors.white),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Rahul Sharma',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Text('Goods Owner',
                    style: TextStyle(color: Colors.black54)),
              ],
            ),
          ),
          IconButton(
              icon: const Icon(Icons.call, color: Colors.green),
              onPressed: () {}),
        ],
      ),
    );
  }

  Widget _otpInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Enter Pickup OTP',
            style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        TextField(
          controller: _otpController,
          maxLength: 4,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: '4 Digit OTP',
            counterText: '',
            filled: true,
            fillColor: Colors.grey.shade100,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: _verifyOtp,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.ridePrimary,
            minimumSize: const Size(double.infinity, 46),
          ),
          child: const Text('Verify OTP', style: TextStyle(color:Colors.white),),
        ),
      ],
    );
  }

  Widget _startRideButton() {
    return ElevatedButton(
      onPressed: isOtpVerified ? _startRide : null,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.ridePrimary,
        minimumSize: const Size(double.infinity, 54),
      ),
      child: const Text('START RIDE', style: TextStyle(fontSize: 18, color: Colors.white)),
    );
  }

  void _verifyOtp() {
    if (_otpController.text == correctOtp) {
      setState(() => isOtpVerified = true);
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('OTP Verified ✅')));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Invalid OTP ❌')));
    }
  }

  void _startRide() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const DriverTripInProgressScreen()),
    );
  }

  Widget _card({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 8),
        ],
      ),
      child: child,
    );
  }
}
