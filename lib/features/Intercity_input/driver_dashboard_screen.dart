import 'package:flutter/material.dart';
import '../porter_partner/screens/portner_verification.dart';
import '../rider/custom_app_bar.dart';
import '../settings/screens/profile_screen.dart';
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

  // Sample upcoming trips
  final List<Map<String, String>> upcomingTrips = [
    {"route": "Indore → Ujjain", "time": "12:00 PM", "seats": "25/40"},
    {"route": "Indore → Ratlam", "time": "3:30 PM", "seats": "18/40"},
    {"route": "Indore → Bhopal", "time": "6:00 PM", "seats": "30/40"},
  ];

  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));

    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero)
            .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Color darkCard(int index) {
    final colors = [
      Colors.blueGrey.shade800,
      Colors.indigo.shade800,
      Colors.teal.shade800,
      Colors.deepPurple.shade800
    ];
    return colors[index % colors.length];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      appBar: CustomHomeAppBar(
        onDutyChanged: (value) {
          setState(() {
            isOnline = value;
          });
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: Column(
              children: [
                // DRIVER INFO CARD
                _buildAnimatedCard(
                  0,
                  Card(
                    color: Colors.black87,
                    elevation: 6,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    child: ListTile(
                      leading: const CircleAvatar(
                        backgroundImage: NetworkImage(
                            "https://i.imgur.com/QCNbOAo.png"),
                        radius: 28,
                      ),
                      title: const Text(
                        "Rahul Driver",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      subtitle: const Text(
                        "⭐ 4.8 | MP09 AB 1234",
                        style: TextStyle(color: Colors.white70),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.edit, color: Colors.white70),
                        onPressed: () {},
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // CURRENT TRIP CARD
                _buildAnimatedCard(
                  1,
                  Card(
                    color: darkCard(0),
                    elevation: 6,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: ListTile(
                      title: const Text(
                        "Current Trip: Indore → Bhopal",
                        style: TextStyle(color: Colors.white),
                      ),
                      subtitle: const Text(
                        "Departure: 10:30 AM | Seats: 30/40",
                        style: TextStyle(color: Colors.white70),
                      ),
                      trailing: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.greenAccent),
                        child: const Text("Accept"),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const PickupVerificationMapScreen()),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // UPCOMING TRIPS TITLE
                _buildAnimatedCard(
                  2,
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Upcoming Trips",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white70),
                    ),
                  ),
                ),
                const SizedBox(height: 8),

                // UPCOMING TRIPS LIST
                Expanded(
                  child: ListView.builder(
                    itemCount: upcomingTrips.length,
                    itemBuilder: (context, index) {
                      final trip = upcomingTrips[index];
                      return _buildAnimatedCard(
                        index + 3,
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          decoration: BoxDecoration(
                            color: darkCard(index + 1),
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: const [
                              BoxShadow(
                                  color: Colors.black54,
                                  blurRadius: 6,
                                  offset: Offset(0, 3))
                            ],
                          ),
                          child: ListTile(
                            title: Text(
                              trip['route']!,
                              style: const TextStyle(color: Colors.white),
                            ),
                            subtitle: Text(
                              "Departure: ${trip['time']} | Seats: ${trip['seats']}",
                              style: const TextStyle(color: Colors.white70),
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.arrow_forward_ios,
                                  color: Colors.white70),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) =>
                                      const TripMapPreviewScreen()),
                                );
                              },
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                // VIEW EARNINGS BUTTON
                _buildAnimatedCard(
                  6,
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amberAccent,
                        foregroundColor: Colors.black,
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12))),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const EarningsScreen()));
                    },
                    child: const Text(
                      "View Earnings",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedCard(int index, Widget child) {
    final delay = Duration(milliseconds: 200 * index);
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: 1),
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOut,
      // key: delay,
      builder: (context, double value, _) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 30 * (1 - value)),
            child: child,
          ),
        );
      },
    );
  }
}
