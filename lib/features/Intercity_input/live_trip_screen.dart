import 'package:cab_bandhu/features/Intercity_input/trip_summary_screen.dart';
import 'package:flutter/material.dart';

class LiveTripScreen extends StatefulWidget {
  const LiveTripScreen({super.key});

  @override
  State<LiveTripScreen> createState() => _LiveTripScreenState();
}

class _LiveTripScreenState extends State<LiveTripScreen> {
  // Example passenger list
  final List<Map<String, dynamic>> passengers = [
    {"name": "Rahul Sharma", "picked": false},
    {"name": "Anjali Verma", "picked": false},
    {"name": "Vikram Singh", "picked": false},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900, // dark background
      appBar: AppBar(
        backgroundColor: Colors.black87,
        iconTheme: const IconThemeData(color: Colors.white), // back button white
        title: const Text(
          "Live Trip / Tracking",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              "Pickup & Drop-off Passengers",
              style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 16),

            Expanded(
              child: ListView.builder(
                itemCount: passengers.length,
                itemBuilder: (context, index) {
                  final passenger = passengers[index];
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 400),
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      color: passenger['picked']
                          ? Colors.green.shade700
                          : Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black54,
                          blurRadius: 6,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: ListTile(
                      title: Text(
                        passenger['name'],
                        style: const TextStyle(color: Colors.black45),
                      ),
                      trailing: Checkbox(
                        activeColor: Colors.greenAccent,
                        checkColor: Colors.black,
                        value: passenger['picked'],
                        onChanged: (val) {
                          setState(() {
                            passengers[index]['picked'] = val;
                          });
                        },
                      ),
                    ),
                  );
                },
              ),
            ),

            // End Trip Button
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 55),
                  backgroundColor: Colors.greenAccent.shade400,
                  foregroundColor: Colors.white,
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  shadowColor: Colors.black54,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const TripSummaryScreen()),
                  );
                },
                child: const Text(
                  "End Trip",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      letterSpacing: 0.5),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
