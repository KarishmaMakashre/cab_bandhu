import 'package:flutter/material.dart';

class PassengerListScreen extends StatelessWidget {
  const PassengerListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Passenger List")),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (_, index) {
          return Card(
            child: ListTile(
              leading: const Icon(Icons.person),
              title: Text("Passenger ${index + 1}"),
              subtitle: Text("Seat: ${index + 1}"),
              trailing: const Icon(Icons.check_circle, color: Colors.green),
            ),
          );
        },
      ),
    );
  }
}
