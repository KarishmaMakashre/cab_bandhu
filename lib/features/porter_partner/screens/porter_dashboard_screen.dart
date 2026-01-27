import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';

import '../../rider/custom_app_bar.dart';

/// ---------------- MOCK PROVIDER ----------------
class LocationProvider extends ChangeNotifier {
  String currentAddress = '';
  Future<void> fetchCurrentLocation() async {
    await Future.delayed(const Duration(seconds: 1));
    currentAddress = "Indore, MP";
    notifyListeners();
  }
}

/// ---------------- MAIN SCREEN ----------------
class PartnerDashboard extends StatefulWidget {
  const PartnerDashboard({super.key});

  @override
  State<PartnerDashboard> createState() => _PartnerDashboardState();
}

class _PartnerDashboardState extends State<PartnerDashboard>
    with TickerProviderStateMixin {
  bool isOnline = false;
  Timer? _requestTimer;
  int selectedTab = 0;

  late AnimationController _chartController;

  final tabs = ['Daily', 'Weekly', 'Monthly'];

  final chartData = [
    [120, 150, 180, 140, 130, 200, 220],
    [500, 620, 580, 700, 650, 720, 800],
    [1200, 1350, 1500, 1450, 1600, 1700, 1800],
  ];

  bool _hasFetchedLocation = false;

  @override
  void initState() {
    super.initState();
    _chartController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..forward();
  }

  void _changeTab(int index) {
    setState(() => selectedTab = index);
    _chartController
      ..reset()
      ..forward();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LocationProvider(),
      child: Consumer<LocationProvider>(
        builder: (context, locationProvider, _) {
          if (!_hasFetchedLocation && locationProvider.currentAddress.isEmpty) {
            _hasFetchedLocation = true;
            WidgetsBinding.instance.addPostFrameCallback((_) {
              locationProvider.fetchCurrentLocation();
            });
          }

          return Scaffold(
            backgroundColor: const Color(0xffF2F4FA),
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
                  _animated(_headerCard()),
                  const SizedBox(height: 18),
                  _animated(_infoBanner()),
                  const SizedBox(height: 18),
                  _animated(_upcomingOrders()),
                  const SizedBox(height: 18),
                  _animated(_withdrawButton()),
                  const SizedBox(height: 26),
                  _animated(_tabBar()),
                  const SizedBox(height: 18),
                  _animated(_chart()),
                  const SizedBox(height: 14),
                  _animated(_monthlyText()),
                  const SizedBox(height: 14),
                  _animated(_breakdown()),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // ---------------- ANIMATION ----------------
  Widget _animated(Widget child) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: const Duration(milliseconds: 600),
      builder: (_, v, __) => Opacity(
        opacity: v,
        child: Transform.translate(
          offset: Offset(0, 30 * (1 - v)),
          child: child,
        ),
      ),
    );
  }

  // ---------------- UI ----------------
  Widget _headerCard() {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient:
        const LinearGradient(colors: [Color(0xff6A11CB), Color(0xff2575FC)]),
        borderRadius: BorderRadius.circular(26),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text("₹150.00",
                style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
            SizedBox(height: 6),
            Text("Wallet Balance",
                style: TextStyle(color: Colors.white70)),
          ]),
          Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
            Text("24",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
            SizedBox(height: 6),
            Text("Total Trips",
                style: TextStyle(color: Colors.white70)),
          ]),
        ],
      ),
    );
  }

  Widget _infoBanner() {
    return _glassCard(
      const Row(
        children: [
          Icon(Icons.auto_graph, color: Color(0xff2575FC)),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              "You earned ₹40 extra via smart sharing!",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          )
        ],
      ),
    );
  }

  Widget _upcomingOrders() {
    final orders = [
      {'time': '4:00 PM', 'route': 'Radisson → Dewas', 'earning': '₹320'},
      {'time': '8:00 PM', 'route': 'Indore → Ujjain', 'earning': '₹450'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Upcoming Orders",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        ...orders.map((o) => Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16)),
          child: ListTile(
            leading: const CircleAvatar(
              backgroundColor: Color(0xffEEF3FF),
              child: Icon(Icons.schedule, color: Color(0xff2575FC)),
            ),
            title: Text(o['time']!),
            subtitle: Text(o['route']!),
            trailing: Text(o['earning']!,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.green)),
          ),
        ))
      ],
    );
  }

  Widget _withdrawButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xff2575FC),
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      onPressed: () {},
      child: const Text("WITHDRAW",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
    );
  }

  Widget _tabBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: List.generate(tabs.length, (i) {
        final selected = selectedTab == i;
        return GestureDetector(
          onTap: () => _changeTab(i),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
            decoration: BoxDecoration(
              color: selected ? const Color(0xff2575FC) : Colors.transparent,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Text(
              tabs[i],
              style: TextStyle(
                  color: selected ? Colors.white : Colors.grey,
                  fontWeight: FontWeight.w600),
            ),
          ),
        );
      }),
    );
  }

  Widget _chart() {
    return _glassCard(
      SizedBox(
        height: 220,
        child: AnimatedBuilder(
          animation: _chartController,
          builder: (_, __) => BarChart(
            BarChartData(
              maxY: 2000,
              titlesData: FlTitlesData(show: false),
              borderData: FlBorderData(show: false),
              barGroups: List.generate(7, (i) {
                final value =
                    chartData[selectedTab][i] * _chartController.value;
                return BarChartGroupData(x: i, barRods: [
                  BarChartRodData(
                    toY: value.toDouble(),
                    width: 16,
                    gradient: const LinearGradient(
                      colors: [Color(0xff6A11CB), Color(0xff2575FC)],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  )
                ]);
              }),
            ),
          ),
        ),
      ),
    );
  }

  Widget _monthlyText() {
    return const Text(
      "Monthly Earnings : ₹1650.50",
      style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Color(0xff2575FC)),
    );
  }

  Widget _breakdown() {
    return _glassCard(
      Column(
        children: const [
          _BreakRow("Trip Earnings", "₹230.50"),
          _BreakRow("Tips", "₹76.54"),
          _BreakRow("Rewards", "₹88.50"),
        ],
      ),
    );
  }

  Widget _glassCard(Widget child) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
        child: Container(
          padding: const EdgeInsets.all(16),
          color: Colors.white.withOpacity(0.8),
          child: child,
        ),
      ),
    );
  }

  // ---------------- LOGIC ----------------
  void _startListeningForRequests() {
    _requestTimer = Timer(const Duration(seconds: 4), () {
      if (isOnline) {
        showDialog(
          context: context,
          builder: (_) => const AlertDialog(
            title: Text("New Order 🚚"),
            content: Text("Pickup: Indore\nDrop: Bhopal\nEarning: ₹320"),
          ),
        );
      }
    });
  }

  void _stopListening() => _requestTimer?.cancel();

  @override
  void dispose() {
    _chartController.dispose();
    _stopListening();
    super.dispose();
  }
}

/// ---------------- BREAK ROW ----------------
class _BreakRow extends StatelessWidget {
  final String title;
  final String value;

  const _BreakRow(this.title, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(color: Colors.grey)),
          Text(value,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xff2575FC))),
        ],
      ),
    );
  }
}
