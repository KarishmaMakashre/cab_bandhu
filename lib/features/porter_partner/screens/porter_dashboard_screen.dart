import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/constants/color_constants.dart';
import '../../../providers/location_provider.dart';
import '../../rider/custom_app_bar.dart';
import 'order_detail_screen.dart';

class PartnerDashboard extends StatefulWidget {
  const PartnerDashboard({super.key});

  @override
  State<PartnerDashboard> createState() => _PartnerDashboardState();
}

class _PartnerDashboardState extends State<PartnerDashboard>
    with SingleTickerProviderStateMixin {
  bool isOnline = false;
  Timer? _requestTimer;
  int selectedTab = 0;

  late AnimationController _chartController;

  final tabs = ['Daily', 'Weekly', 'Monthly'];

  final chartData = [
    [120, 150, 180, 140, 130, 200, 220], // Daily
    [500, 620, 580, 700, 650, 720, 800], // Weekly
    [1200, 1350, 1500, 1450, 1600, 1700, 1800], // Monthly
  ];

  bool _hasFetchedLocation = false;

  @override
  void initState() {
    super.initState();
    _chartController =
    AnimationController(vsync: this, duration: const Duration(milliseconds: 800))
      ..forward();
  }

  void _changeTab(int index) {
    setState(() {
      selectedTab = index;
    });
    _chartController.reset();
    _chartController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LocationProvider(),
      child: Consumer<LocationProvider>(
        builder: (context, locationProvider, child) {
          if (!_hasFetchedLocation && locationProvider.currentAddress.isEmpty) {
            _hasFetchedLocation = true;
            WidgetsBinding.instance.addPostFrameCallback((_) {
              locationProvider.fetchCurrentLocation();
            });
          }

          return Scaffold(
            backgroundColor: const Color(0xFF121212),
            appBar: CustomHomeAppBar(
              onDutyChanged: (value) {
                setState(() {
                  isOnline = value;
                });
              },
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // Balance + Trips Card
                  _animatedFadeSlide(child: _topStatsCard()),
                  const SizedBox(height: 16),

                  // Porter sharing
                  _animatedFadeSlide(child: _porterSharingEarningsCard()),
                  const SizedBox(height: 16),

                  // Upcoming Orders
                  _animatedFadeSlide(child: _upcomingOrdersCard()),
                  const SizedBox(height: 16),

                  // Withdraw button
                  _animatedFadeSlide(child: _withdrawButton()),
                  const SizedBox(height: 24),

                  // Earnings tabs
                  _animatedFadeSlide(child: _tabBar()),
                  const SizedBox(height: 20),

                  // Animated bar chart
                  _animatedFadeSlide(child: _animatedBarChart()),

                  const SizedBox(height: 16),
                  _animatedFadeSlide(child: _monthlyTextWidget()),
                  const SizedBox(height: 16),

                  // Earnings breakdown
                  _animatedFadeSlide(child: _breakdownCard()),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // 🔹 Fade + Slide animation wrapper
  Widget _animatedFadeSlide({required Widget child}) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: const Duration(milliseconds: 600),
      builder: (context, value, widget) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 30 * (1 - value)),
            child: child,
          ),
        );
      },
      child: child,
    );
  }

  // 🔹 Balance + Trips Card
// 🔹 Balance + Trips Card (White)
  Widget _topStatsCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white, // white card
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [
            Text('₹150.00',
                style: TextStyle(
                    fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black)),
            SizedBox(height: 4),
            Text('Your Balance', style: TextStyle(color: Colors.black54)),
          ]),
          Column(crossAxisAlignment: CrossAxisAlignment.end, children: const [
            Text('24',
                style: TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold, color: Colors.orange)),
            SizedBox(height: 4),
            Text('Total Trips', style: TextStyle(color: Colors.black54)),
          ]),
        ],
      ),
    );
  }

// 🔹 Porter sharing card (Yellow)
  Widget _porterSharingEarningsCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.yellow.shade100, // yellow card
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Row(
        children: [
          Icon(Icons.share, color: Colors.orange),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              'You earned ₹40 extra via Porter Sharing!',
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.orange),
            ),
          ),
        ],
      ),
    );
  }

// 🔹 Upcoming Orders Card (GreenAccent)
  Widget _upcomingOrdersCard() {
    final upcomingOrders = [
      {
        'time': 'Evening 4 PM',
        'pickup': 'Radisson',
        'drop': 'Dewas',
        'earning': '₹320',
      },
      {
        'time': 'Night 8 PM',
        'pickup': 'Indore Mall',
        'drop': 'Ujjain',
        'earning': '₹450',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Upcoming Orders',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        const SizedBox(height: 12),
        ...upcomingOrders.map((order) => Card(
          color: Colors.greenAccent.shade100, // greenAccent card
          margin: const EdgeInsets.only(bottom: 8),
          child: ListTile(
            leading: const Icon(Icons.schedule, color: Colors.green),
            title: Text('${order['time']}',
                style: const TextStyle(color: Colors.black)),
            subtitle: Text('${order['pickup']} to ${order['drop']}',
                style: const TextStyle(color: Colors.black87)),
            trailing: Text(
              order['earning']!,
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.green),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const OrderDetailScreen(),
                ),
              );
            },
          ),
        )),
      ],
    );
  }

  // 🔹 Withdraw Button
  Widget _withdrawButton() {
    return SizedBox(
      width: 160,
      height: 44,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.greenAccent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        child: const Text('WITHDRAWAL', style: TextStyle(color: Colors.black)),
      ),
    );
  }

  // 🔹 Tab Bar
  Widget _tabBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: List.generate(tabs.length, (index) {
        final selected = selectedTab == index;
        return GestureDetector(
          onTap: () => _changeTab(index),
          child: Column(
            children: [
              Text(
                tabs[index],
                style: TextStyle(
                  color: selected ? Colors.greenAccent : Colors.white70,
                  fontWeight: FontWeight.w600,
                ),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.only(top: 6),
                width: selected ? 40 : 0,
                height: 2,
                color: Colors.greenAccent,
              )
            ],
          ),
        );
      }),
    );
  }

  // 🔹 Animated Bar Chart
  Widget _animatedBarChart() {
    return Container(
      height: 220,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white, // White background for the chart
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            spreadRadius: 2,
          ),
        ],
      ),
      child: AnimatedBuilder(
        animation: _chartController,
        builder: (_, __) {
          return BarChart(
            BarChartData(
              maxY: 2000,
              borderData: FlBorderData(show: false),
              gridData: FlGridData(
                show: true,
                drawHorizontalLine: true,
                drawVerticalLine: true, // Enable vertical lines
                horizontalInterval: 500,
                verticalInterval: 1,
                getDrawingHorizontalLine: (value) {
                  return FlLine(
                    color: Colors.white, // White horizontal lines
                    strokeWidth: 1,
                  );
                },
                getDrawingVerticalLine: (value) {
                  return FlLine(
                    color: Colors.white, // White vertical lines
                    strokeWidth: 1,
                  );
                },
              ),
              titlesData: FlTitlesData(
                topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    interval: 500,
                    getTitlesWidget: (value, meta) {
                      return Text(
                        value.toInt().toString(),
                        style: const TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
                      );
                    },
                  ),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      const days = ['M', 'Tu', 'W', 'Th', 'F', 'Sa', 'Su'];
                      return Text(
                        days[value.toInt()],
                        style: const TextStyle(
                            color: Colors.black87, fontWeight: FontWeight.bold),
                      );
                    },
                  ),
                ),
              ),
              barGroups: List.generate(7, (index) {
                final value = chartData[selectedTab][index] * _chartController.value;
                return BarChartGroupData(x: index, barRods: [
                  BarChartRodData(
                    toY: value.toDouble(),
                    width: 18,
                    color: Colors.greenAccent,
                    borderRadius: BorderRadius.circular(6),
                  ),
                ]);
              }),
            ),
          );
        },
      ),
    );
  }


  // 🔹 Monthly Text
  Widget _monthlyTextWidget() {
    return const Text(
      'Monthly Earnings : Rs 1650.50',
      style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold),
    );
  }

  // 🔹 Breakdown card
  Widget _breakdownCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade900,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade700),
      ),
      child: Column(
        children: [
          _breakdownRow('Trip Earnings', 'Rs 230.50'),
          _breakdownRow('Toll Charges', 'Rs 40.50'),
          _breakdownRow('Tips', 'Rs 76.54'),
          _breakdownRow('Rewards', 'Rs 88.50'),
          _breakdownRow('Other adjustments', 'Rs 6.50'),
        ],
      ),
    );
  }

  Widget _breakdownRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(color: Colors.white70)),
          Text(value, style: const TextStyle(color: Colors.redAccent)),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _stopListening();
    _chartController.dispose();
    super.dispose();
  }

  void _startListeningForRequests() {
    _requestTimer = Timer(const Duration(seconds: 4), () {
      if (isOnline) _showOrderRequestPopup();
    });
  }

  void _stopListening() => _requestTimer?.cancel();

  void _showOrderRequestPopup() {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Dismiss',
      barrierColor: Colors.black.withOpacity(0.5),
      pageBuilder: (_, __, ___) => Align(
        alignment: Alignment.center,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.grey.shade900,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.local_shipping, size: 48, color: Colors.greenAccent),
                const SizedBox(height: 16),
                const Text(
                  'New Order 🚚',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Pickup: Indore\nDrop: Bhopal\nEarning: ₹320',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white70),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancel', style: TextStyle(color: Colors.white)),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.greenAccent,
                      ),
                      child: const Text('View Order', style: TextStyle(color: Colors.black)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      transitionBuilder: (_, animation, __, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 0.5),
            end: Offset.zero,
          ).animate(CurvedAnimation(
            parent: animation,
            curve: Curves.easeInOutCubic,
          )),
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 300),
    );
  }
}
