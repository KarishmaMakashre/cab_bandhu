import 'package:flutter/material.dart';

class IntercityRidePorterScreen extends StatefulWidget {
  const IntercityRidePorterScreen({super.key});

  @override
  State<IntercityRidePorterScreen> createState() =>
      _IntercityRidePorterScreenState();
}

class _IntercityRidePorterScreenState
    extends State<IntercityRidePorterScreen> with TickerProviderStateMixin {
  final List<Map<String, String>> trips = [
    {
      "route": "Indore → Bhopal",
      "time": "10:30 AM",
      "seats": "30/40",
      "porter": "Rahul"
    },
    {
      "route": "Indore → Ujjain",
      "time": "12:00 PM",
      "seats": "25/40",
      "porter": "Anjali"
    },
    {
      "route": "Indore → Ratlam",
      "time": "3:30 PM",
      "seats": "18/40",
      "porter": "Vikram"
    },
  ];

  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  List<bool> isFavorite = [];

  @override
  void initState() {
    super.initState();
    isFavorite = List.filled(trips.length, false);

    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
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
          "Intercity Rides & Porter",
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20),
        ),
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ListView.builder(
            itemCount: trips.length,
            itemBuilder: (context, index) {
              final trip = trips[index];
              return AnimatedContainer(
                duration: const Duration(milliseconds: 500),
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            trip['route']!,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            isFavorite[index]
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: isFavorite[index]
                                ? Colors.red
                                : Colors.white70,
                          ),
                          onPressed: () {
                            setState(() {
                              isFavorite[index] = !isFavorite[index];
                            });
                          },
                        )
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Departure: ${trip['time']} | Seats: ${trip['seats']}",
                      style:
                      const TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Porter: ${trip['porter']!}",
                      style: const TextStyle(
                          color: Colors.greenAccent, fontSize: 14),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.amberAccent,
                              foregroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12))),
                          onPressed: () {
                            // Navigate to details / map / booking screen
                          },
                          child: const Text("Book / Details"),
                        )
                      ],
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
