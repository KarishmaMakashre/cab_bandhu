import 'package:flutter/material.dart';
import '../porter_partner/screens/portner_verification.dart';
import '../rider/custom_app_bar.dart';
import 'live_trip_map_screen.dart';
import 'earnings_screen.dart';

class DriverDashboardScreen extends StatefulWidget {
  const DriverDashboardScreen({super.key});

  @override
  State<DriverDashboardScreen> createState() => _DriverDashboardScreenState();
}

class _DriverDashboardScreenState extends State<DriverDashboardScreen>
    with TickerProviderStateMixin {
  bool isOnline = false;

  final List<Map<String, String>> upcomingTrips = [
    {"route": "Indore → Ujjain", "time": "12:00 PM", "seats": "25/40"},
    {"route": "Indore → Ratlam", "time": "3:30 PM", "seats": "18/40"},
    {"route": "Indore → Bhopal", "time": "6:00 PM", "seats": "30/40"},
  ];

  late AnimationController _controller;
  late Animation<double> _fade;
  late Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 700));
    _fade = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _slide = Tween<Offset>(
      begin: const Offset(0, 0.15),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: CustomHomeAppBar(
        onDutyChanged: (value) => setState(() => isOnline = value),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: FadeTransition(
          opacity: _fade,
          child: SlideTransition(
            position: _slide,
            child: Column(
              children: [

                /// 👤 DRIVER INFO
                _animatedCard(
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    child: ListTile(
                      leading: const CircleAvatar(
                        radius: 28,
                        backgroundImage:
                        NetworkImage("https://i.imgur.com/QCNbOAo.png"),
                      ),
                      title: const Text(
                        "Rahul Driver",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: const Text("⭐ 4.8 | MP09 AB 1234"),
                      trailing: IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {},
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                /// 🚗 CURRENT TRIP
                _animatedCard(
                    Card(
                      elevation: 6,
                      shadowColor: Colors.green.withOpacity(0.15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: LinearGradient(
                            colors: [
                              Colors.green.withOpacity(0.08),
                              Colors.green.withOpacity(0.03),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                          child: Row(
                            children: [
                              /// 🚍 Trip Icon
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.green.withOpacity(0.15),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.directions_bus,
                                  color: Colors.green,
                                  size: 26,
                                ),
                              ),

                              const SizedBox(width: 14),

                              /// 📍 Trip Info
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text(
                                      "Indore → Bhopal",
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(height: 6),
                                    Text(
                                      "Departure 10:30 AM • Seats 30/40",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              /// ✅ Accept Button
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                  foregroundColor: Colors.white,
                                  elevation: 0,
                                  padding:
                                  const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => const PickupVerificationMapScreen(),
                                    ),
                                  );
                                },
                                child: const Text(
                                  "Accept",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                ),

                const SizedBox(height: 20),

                /// 📅 UPCOMING TITLE
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Upcoming Trips",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                /// 📋 UPCOMING LIST
                Expanded(
                  child: ListView.builder(
                    itemCount: upcomingTrips.length,
                    itemBuilder: (_, index) {
                      final trip = upcomingTrips[index];
                      return _animatedCard(
                        Card(
                          elevation: 3,
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)),
                          child: ListTile(
                            title: Text(
                              trip['route']!,
                              style:
                              const TextStyle(fontWeight: FontWeight.w600),
                            ),
                            subtitle: Text(
                              "Departure: ${trip['time']} | Seats: ${trip['seats']}",
                            ),
                            trailing: const Icon(Icons.arrow_forward_ios,
                                size: 16),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                  const TripMapPreviewScreen(),
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),

                /// 💰 EARNINGS BUTTON
                _animatedCard(
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber,
                      foregroundColor: Colors.black,
                      minimumSize: const Size(double.infinity, 52),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const EarningsScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      "View Earnings",
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _animatedCard(Widget child) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: const Duration(milliseconds: 450),
      curve: Curves.easeOut,
      builder: (_, value, __) => Opacity(
        opacity: value,
        child: Transform.translate(
          offset: Offset(0, 25 * (1 - value)),
          child: child,
        ),
      ),
    );
  }
}
