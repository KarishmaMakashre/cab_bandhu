import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_constants.dart';
import '../../../providers/location_provider.dart';
import '../../rider/custom_app_bar.dart';
import 'order_detail_screen.dart';

const Color primaryGreen = Color(0xff43A047);

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
    [420, 150, 180, 140, 130, 200, 220],
    [500, 620, 580, 700, 650, 720, 800],
    [1200, 1350, 1500, 1450, 1600, 1700, 1800],
  ];

  bool _hasFetchedLocation = false;

  @override
  void initState() {
    super.initState();
    _chartController =
    AnimationController(vsync: this, duration: const Duration(milliseconds: 700))
      ..forward();
  }

  void _changeTab(int index) {
    setState(() => selectedTab = index);
    _chartController
      ..reset()
      ..forward();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );

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
            appBar: CustomHomeAppBar(
              onDutyChanged: (value) {
                setState(() => isOnline = value);
              },
            ),
            drawer: _drawer(locationProvider),
            body: Stack(
              children: [
                /// 🌄 BACKGROUND IMAGE
                Positioned.fill(
                  child: Image.asset(
                    'assets/images/backgroundImg.jpeg',
                    fit: BoxFit.cover,
                  ),
                ),

                /// ☁️ LIGHT OVERLAY
                Positioned.fill(
                  child: Container(color: Colors.white.withOpacity(0.85)),
                ),

                /// MAIN CONTENT
                SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _topStats(),
                      const SizedBox(height: 16),
                      _infoBanner(),
                      const SizedBox(height: 16),
                      _upcomingOrders(),
                      const SizedBox(height: 16),
                      _withdrawButton(),
                      const SizedBox(height: 24),
                      _tabWithChart(),
                      const SizedBox(height: 16),
                      _monthlyText(),
                      const SizedBox(height: 16),
                      _breakdownCard(),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // ================= TOP STATS =================
  Widget _topStats() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [
          Text('₹150.00',
              style: TextStyle(color:Colors.black,fontSize: 24, fontWeight: FontWeight.bold)),
          Text('Wallet Balance', style: TextStyle(color: Colors.grey)),
        ]),
        Column(crossAxisAlignment: CrossAxisAlignment.end, children: const [
          Text('24',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: primaryGreen)),
          Text('Total Trips', style: TextStyle(color: Colors.grey)),
        ]),
      ],
    );
  }

  // ================= INFO BANNER =================
  Widget _infoBanner() {
    return _whiteCard(
      Row(
        children: const [
          Icon(Icons.auto_graph, color: primaryGreen),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              'You earned ₹40 extra via smart sharing!',
              style: TextStyle(fontWeight: FontWeight.w600,color: Colors.black45),
            ),
          ),
        ],
      ),
    );
  }

  // ================= UPCOMING ORDERS =================
  Widget _upcomingOrders() {
    final orders = [
      {'time': '4:00 PM', 'route': 'Radisson → Dewas', 'earning': '₹320'},
      {'time': '8:00 PM', 'route': 'Indore → Ujjain', 'earning': '₹450'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Upcoming Orders',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        const SizedBox(height: 12),
        ...orders.map(
              (o) => Container(
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: primaryGreen.withOpacity(0.12),
                child: const Icon(Icons.schedule, color: primaryGreen),
              ),
              title: Text(
                o['time']!,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              subtitle: Text(o['route']!),
              trailing: Text(
                o['earning']!,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: primaryGreen,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const OrderDetailScreen(),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  // ================= WITHDRAW =================
  Widget _withdrawButton() {
    return SizedBox(
      width: 160,
      height: 44,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryGreen,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        child: const Text('WITHDRAW',style: TextStyle(color: Colors.white),),
      ),
    );
  }

  Widget _monthlyText() {
    return const Text(
      'Monthly Earnings : ₹1650.50',
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: primaryGreen,
      ),
    );
  }

  // ================= BREAKDOWN =================
  Widget _breakdownCard() {
    return _whiteCard(
      Column(
        children: const [
          _Row('Trip Earnings', '₹230.50'),
          _Row('Tips', '₹76.54'),
          _Row('Rewards', '₹88.50'),
        ],
      ),
    );
  }

  Widget _whiteCard(Widget child) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _drawer(LocationProvider provider) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: primaryGreen),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(
                  radius: 26,
                  backgroundImage: AssetImage(AppConstants.proterProfilePath),
                ),
                const SizedBox(height: 10),
                const Text('John Doe',
                    style: TextStyle(color: Colors.white, fontSize: 18)),
                Text(
                  provider.currentAddress.isEmpty
                      ? 'Fetching location...'
                      : provider.currentAddress,
                  style: const TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _requestTimer?.cancel();
    _chartController.dispose();
    super.dispose();
  }

  Widget _tabWithChart() {
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 14, 12, 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          /// ================= TABS =================
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(tabs.length, (i) {
              final selected = selectedTab == i;
              return GestureDetector(
                onTap: () => _changeTab(i),
                child: Column(
                  children: [
                    Text(
                      tabs[i],
                      style: TextStyle(
                        color: selected ? primaryGreen : Colors.grey,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 6),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      height: 2,
                      width: selected ? 36 : 0,
                      color: primaryGreen,
                    ),
                  ],
                ),
              );
            }),
          ),

          const SizedBox(height: 16),

          /// ================= BAR CHART =================
          SizedBox(
            height: 220,
            child: AnimatedBuilder(
              animation: _chartController,
              builder: (_, __) => BarChart(
                BarChartData(
                  maxY: 400,
                  borderData: FlBorderData(show: false),
                  gridData: FlGridData(show: false),
                  titlesData: FlTitlesData(show: false),
                  barGroups: List.generate(7, (i) {
                    final value =
                        chartData[selectedTab][i] * _chartController.value;
                    return BarChartGroupData(
                      x: i,
                      barRods: [
                        BarChartRodData(
                          toY: value.toDouble(),
                          width: 16,
                          color: primaryGreen,
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ],
                    );
                  }),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

}

class _Row extends StatelessWidget {
  final String t, v;
  const _Row(this.t, this.v);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(t, style: const TextStyle(color: Colors.grey)),
          Text(v,
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: primaryGreen)),
        ],
      ),
    );
  }
}
