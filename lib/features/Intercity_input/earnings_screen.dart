import 'package:flutter/material.dart';

class EarningsScreen extends StatefulWidget {
  const EarningsScreen({super.key});

  @override
  State<EarningsScreen> createState() => _EarningsScreenState();
}

class _EarningsScreenState extends State<EarningsScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 800));
    _fadeAnimation =
        CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  final List<Map<String, dynamic>> earnings = [
    {
      "title": "Today's Earnings",
      "amount": "₹850",
      "icon": Icons.today,
      "color": Colors.green
    },
    {
      "title": "Weekly Earnings",
      "amount": "₹5,200",
      "icon": Icons.calendar_month,
      "color": Colors.blue
    },
    {
      "title": "Wallet Balance",
      "amount": "₹1,300",
      "icon": Icons.account_balance_wallet,
      "color": Colors.orange
    },
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
          "Earnings",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: earnings.map((e) => _earningCard(e)).toList(),
          ),
        ),
      ),
    );
  }

  /// 💰 Earnings Card
  Widget _earningCard(Map<String, dynamic> e) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: [
            e['color'].withOpacity(0.10),
            e['color'].withOpacity(0.03),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        // boxShadow: [
        //   BoxShadow(
        //     color: e['color'].withOpacity(0.15),
        //     blurRadius: 12,
        //     offset: const Offset(0, 6),
        //   )
        // ],
      ),
      child: Row(
        children: [
          /// Icon
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: e['color'].withOpacity(0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(
              e['icon'],
              color: e['color'],
              size: 26,
            ),
          ),

          const SizedBox(width: 14),

          /// Text
          Expanded(
            child: Text(
              e['title'],
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          /// Amount
          Text(
            e['amount'],
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: e['color'],
            ),
          ),
        ],
      ),
    );
  }
}
