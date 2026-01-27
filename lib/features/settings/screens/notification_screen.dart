import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/constants/color_constants.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

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
      'message': 'Upcoming ride to airport.',
    },
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
    final Color statusColor =
    item['status'] == 'Dropped' ? Colors.green : AppColors.ridePrimary;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          /// HEADER
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(item['icon'], color: statusColor, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item['status'],
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item['date'],
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
              if (item['price'] != 'N/A')
                Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    item['price'],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                ),
            ],
          ),

          const SizedBox(height: 14),

          /// ORIGIN
          Row(
            children: [
              const Icon(Icons.my_location, size: 16, color: Colors.green),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  item['origin'],
                  style: const TextStyle(color: Colors.black87),
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          /// DESTINATION
          Row(
            children: [
              const Icon(Icons.location_on, size: 16, color: Colors.red),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  item['destination'],
                  style: const TextStyle(color: Colors.black87),
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          /// MESSAGE
          Text(
            item['message'],
            style: const TextStyle(
              fontSize: 12,
              color: Colors.black54,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.08);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          'Notifications',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),

        bottom: TabBar(
          controller: _tabController,
          labelColor: AppColors.ridePrimary,
          unselectedLabelColor: Colors.black54,
          indicatorColor: AppColors.ridePrimary,
          indicatorWeight: 3,
          tabs: const [
            Tab(text: 'Past'),
            Tab(text: 'Upcoming'),
          ],
        ),
      ),

      body: TabBarView(
        controller: _tabController,
        children: [
          _buildTab('past'),
          _buildTab('upcoming'),
        ],
      ),
    );
  }

  Widget _buildTab(String tab) {
    final list =
    _dummyNotifications.where((item) => item['tab'] == tab).toList();

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: list.length,
      itemBuilder: (_, i) => _buildNotificationItem(list[i]),
    );
  }
}
