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
        AnimationController(vsync: this, duration: const Duration(milliseconds: 800));
    _animationController.forward();
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
      backgroundColor: const Color(0xFF121212),
      body: Stack(
        children: [
          // 🌍 Google Map
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

          // 🔙 Back Button
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: CircleAvatar(
                backgroundColor: Colors.grey.shade800,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => context.pop(),
                ),
              ),
            ),
          ),

          // ⬆️ Bottom Sheet
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.58,
              decoration: const BoxDecoration(
                color: Color(0xFF1E1E1E),
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 12)],
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
                    _animatedFadeSlide(_receiverDetails(), delay: 200),
                    const SizedBox(height: 20),
                    _animatedFadeSlide(_goodsSummary(), delay: 300),
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

  Widget _animatedFadeSlide(Widget child, {int delay = 0}) {
    return FadeTransition(
      opacity: CurvedAnimation(
        parent: _animationController,
        curve: Interval(delay / 1000, 1.0, curve: Curves.easeOut),
      ),
      child: SlideTransition(
        position: Tween<Offset>(begin: const Offset(0, 0.1), end: Offset.zero)
            .animate(CurvedAnimation(
          parent: _animationController,
          curve: Interval(delay / 1000, 1.0, curve: Curves.easeOut),
        )),
        child: child,
      ),
    );
  }

  Widget _pickupAddressWidget() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(Icons.location_on, color: Colors.greenAccent),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            pickupAddress,
            style: const TextStyle(
                fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
          ),
        ),
      ],
    );
  }

  Widget _ownerDetails() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: _card(color: Colors.grey.shade900),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 24,
            backgroundColor: Colors.greenAccent,
            child: Icon(Icons.person, color: Colors.black),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Rahul Sharma',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white)),
                Text('Goods Owner', style: TextStyle(color: Colors.white70)),
              ],
            ),
          ),
          IconButton(icon: const Icon(Icons.call, color: Colors.greenAccent), onPressed: () {}),
        ],
      ),
    );
  }

  Widget _receiverDetails() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: _card(color: Colors.blueGrey.shade900),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Receiver Details',
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 14, color: Colors.white)),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CircleAvatar(
                radius: 24,
                backgroundColor: Colors.orange,
                child: Icon(Icons.home, color: Colors.white),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Amit Verma',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Colors.white)),
                    const SizedBox(height: 4),
                    Text('MP Nagar Zone 1, Bhopal',
                        style: const TextStyle(color: Colors.white70, fontSize: 13)),
                    const SizedBox(height: 6),
                    Text('+91 9876543210',
                        style: const TextStyle(
                            fontWeight: FontWeight.w500, color: Colors.white, fontSize: 13)),
                  ],
                ),
              ),
              IconButton(icon: const Icon(Icons.call, color: Colors.greenAccent), onPressed: () {}),
            ],
          ),
        ],
      ),
    );
  }

  Widget _goodsSummary() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: _card(color: Colors.green.shade900),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text('Goods Summary',
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 14, color: Colors.white)),
          SizedBox(height: 8),
          Text('• Bed, Table, Chairs', style: TextStyle(color: Colors.white70)),
          Text('• Weight: 120 kg', style: TextStyle(color: Colors.white70)),
          Text('• Fragile items included', style: TextStyle(color: Colors.white70)),
        ],
      ),
    );
  }

  Widget _otpInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Enter Pickup OTP',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        const SizedBox(height: 10),
        TextField(
          controller: _otpController,
          maxLength: 4,
          keyboardType: TextInputType.number,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: '4 Digit OTP',
            hintStyle: const TextStyle(color: Colors.white54),
            counterText: '',
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Colors.white38)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Colors.greenAccent)),
          ),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: _verifyOtp,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.greenAccent,
            minimumSize: const Size(double.infinity, 46),
            foregroundColor: Colors.black,
          ),
          child: const Text('Verify OTP'),
        ),
      ],
    );
  }

  Widget _startRideButton() {
    return ElevatedButton(
      onPressed: isOtpVerified ? _startRide : null,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.greenAccent,
        disabledBackgroundColor: Colors.grey,
        minimumSize: const Size(double.infinity, 54),
        foregroundColor: Colors.black,
      ),
      child: const Text('START RIDE', style: TextStyle(fontSize: 18)),
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

  BoxDecoration _card({Color color = Colors.grey}) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade700),
      color: color,
    );
  }
}
