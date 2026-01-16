import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/color_constants.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Dummy data for notifications
  final List<Map<String, dynamic>> _dummyNotifications = [
    {
      'tab': 'past',
      'status': 'Dropped',
      'icon': Icons.directions_car,
      'date': '2 days ago',
      'time': 'Mar 10, 2022 - 4:45 PM',
      'price': '₹28.12',
      'origin': '22, MP-10, Indore, Madhya Pradesh',
      'destination': '16, Acotel Hub, Indore, Madhya Pradesh',
      'type': 'ride',
      'message': 'Ride dropped successfully!',
    },
    {
      'tab': 'upcoming',
      'status': 'Upcoming',
      'icon': Icons.schedule,
      'date': 'Tomorrow',
      'time': 'Apr 09, 2025 - 10:00 AM',
      'price': '₹50.00',
      'origin': 'Your current location',
      'destination': 'Airport, Indore',
      'type': 'ride',
      'message': 'Upcoming ride to airport.',
    },
    // Add other notifications here...
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget _buildNotificationItem(Map<String, dynamic> item) {
    Color statusColor = item['status'] == 'Dropped' || item['status'] == 'Paid'
        ? Colors.green
        : item['status'] == 'Cancelled'
        ? Colors.red
        : Colors.greenAccent;

    IconData icon = item['icon'];
    String status = item['status'];
    String date = item['date'];
    String price = item['price'];
    String origin = item['origin'];
    String destination = item['destination'];
    String message = item['message'];

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade100, // Panel color
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: statusColor, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      status,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      date,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
              if (price != 'N/A')
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.greenAccent.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    price,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.location_on, color: Colors.green, size: 16),
              ),
              const SizedBox(width: 8),
              Expanded(child: Text(origin, style: const TextStyle(color: Colors.black))),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.location_on, color: Colors.red, size: 16),
              ),
              const SizedBox(width: 8),
              Expanded(child: Text(destination, style: const TextStyle(color: Colors.black))),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            message,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.black54,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.05);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        title: const Text('Notifications', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF121212),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),

        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.greenAccent,
          unselectedLabelColor: Colors.white,
          indicatorColor: Colors.greenAccent,
          tabs: const [
            Tab(text: 'Past'),
            Tab(text: 'Upcoming'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Past Tab
          ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: _dummyNotifications.where((item) => item['tab'] == 'past').length,
            separatorBuilder: (context, index) => Divider(color: Colors.grey[300], height: 1),
            itemBuilder: (context, index) {
              final item = _dummyNotifications.where((item) => item['tab'] == 'past').toList()[index];
              return _buildNotificationItem(item);
            },
          ),
          // Upcoming Tab
          ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: _dummyNotifications.where((item) => item['tab'] == 'upcoming').length,
            separatorBuilder: (context, index) => Divider(color: Colors.grey[300], height: 1),
            itemBuilder: (context, index) {
              final item = _dummyNotifications.where((item) => item['tab'] == 'upcoming').toList()[index];
              return _buildNotificationItem(item);
            },
          ),
        ],
      ),
    );
  }
}
