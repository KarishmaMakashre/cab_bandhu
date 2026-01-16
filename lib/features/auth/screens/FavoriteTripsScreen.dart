import 'package:flutter/material.dart';

class FavoriteTripsScreen extends StatefulWidget {
  const FavoriteTripsScreen({super.key});

  @override
  State<FavoriteTripsScreen> createState() => _FavoriteTripsScreenState();
}

class _FavoriteTripsScreenState extends State<FavoriteTripsScreen>
    with TickerProviderStateMixin {
  // Sample favorite trips
  final List<Map<String, String>> favoriteTrips = [
    {"route": "Indore → Bhopal", "time": "10:30 AM", "seats": "30/40"},
    {"route": "Indore → Ujjain", "time": "12:00 PM", "seats": "25/40"},
    {"route": "Indore → Ratlam", "time": "3:30 PM", "seats": "18/40"},
    {"route": "Indore → Bhopal", "time": "6:00 PM", "seats": "30/40"},
  ];

  late AnimationController _controller;
  late List<Animation<double>> _fadeAnimations;
  late List<Animation<Offset>> _slideAnimations;

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));

    _fadeAnimations = favoriteTrips
        .asMap()
        .entries
        .map((entry) => Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(
            0.1 * entry.key, 0.6 + 0.1 * entry.key,
            curve: Curves.easeIn),
      ),
    ))
        .toList();

    _slideAnimations = favoriteTrips
        .asMap()
        .entries
        .map((entry) => Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Interval(
          0.1 * entry.key, 0.6 + 0.1 * entry.key,
          curve: Curves.easeOut),
    )))
        .toList();

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
      appBar: AppBar(
        backgroundColor: Colors.black87,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Favorite Trips",
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView.builder(
          itemCount: favoriteTrips.length,
          itemBuilder: (context, index) {
            final trip = favoriteTrips[index];
            return FadeTransition(
              opacity: _fadeAnimations[index],
              child: SlideTransition(
                position: _slideAnimations[index],
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: darkCard(index),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black54,
                          blurRadius: 6,
                          offset: Offset(0, 3))
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            trip['route']!,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "Departure: ${trip['time']} | Seats: ${trip['seats']}",
                            style: const TextStyle(
                                color: Colors.white70, fontSize: 14),
                          ),
                        ],
                      ),
                      IconButton(
                        icon: const Icon(Icons.favorite_border,
                            color: Colors.white70),
                        onPressed: () {
                          // TODO: toggle favorite
                        },
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
