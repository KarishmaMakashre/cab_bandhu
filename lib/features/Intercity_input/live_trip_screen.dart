import 'package:cab_bandhu/features/Intercity_input/trip_summary_screen.dart';
import 'package:flutter/material.dart';

class LiveTripScreen extends StatefulWidget {
  const LiveTripScreen({super.key});

  @override
  State<LiveTripScreen> createState() => _LiveTripScreenState();
}

class _LiveTripScreenState extends State<LiveTripScreen> {
  final List<Map<String, dynamic>> passengers = [
    {"name": "Rahul Sharma", "picked": false},
    {"name": "Anjali Verma", "picked": false},
    {"name": "Vikram Singh", "picked": false},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB), // light background
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          "Live Trip / Tracking",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Title
            const Text(
              "Pickup & Drop-off Passengers",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 12),

            /// Passenger List
            Expanded(
              child: ListView.builder(
                itemCount: passengers.length,
                itemBuilder: (context, index) {
                  final passenger = passengers[index];
                  final bool picked = passenger['picked'];

                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 400),
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 10),
                    decoration: BoxDecoration(
                      color: picked
                          ? Colors.green.withOpacity(0.12)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(
                        color: picked
                            ? Colors.green
                            : Colors.grey.shade300,
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 8,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        /// Status Icon
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: picked
                              ? Colors.green
                              : Colors.grey.shade300,
                          child: Icon(
                            picked ? Icons.check : Icons.person,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                        const SizedBox(width: 12),

                        /// Name
                        Expanded(
                          child: Text(
                            passenger['name'],
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: picked
                                  ? Colors.green.shade800
                                  : Colors.black87,
                            ),
                          ),
                        ),

                        /// Checkbox
                        Checkbox(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          activeColor: Colors.green,
                          value: picked,
                          onChanged: (val) {
                            setState(() {
                              passengers[index]['picked'] = val;
                            });
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            /// End Trip Button
            SafeArea(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 56),
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const TripSummaryScreen(),
                    ),
                  );
                },
                child: const Text(
                  "End Trip",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    letterSpacing: 0.4,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
