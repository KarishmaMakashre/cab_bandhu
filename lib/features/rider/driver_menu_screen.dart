import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DriverMenuScreen extends StatefulWidget {
  const DriverMenuScreen({super.key});

  @override
  State<DriverMenuScreen> createState() => _DriverMenuScreenState();
}

class _DriverMenuScreenState extends State<DriverMenuScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Widget _animatedFadeSlide(Widget child, {int delay = 0}) {
    return FadeTransition(
      opacity: CurvedAnimation(
        parent: _animationController,
        curve: Interval(delay / 1000, 1.0, curve: Curves.easeOut),
      ),
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 0.08),
          end: Offset.zero,
        ).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Interval(delay / 1000, 1.0, curve: Curves.easeOut),
          ),
        ),
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            /// 🖼 BACKGROUND IMAGE
            Positioned.fill(
              child: Image.asset(
                'assets/images/backgroundImg.jpeg',
                fit: BoxFit.cover,
              ),
            ),

            /// 🌫 SOFT OVERLAY (keeps premium dark-trip feel)
            Positioned.fill(
              child: Container(
                color: Colors.white.withOpacity(0.85),
              ),
            ),

            /// 🧱 ORIGINAL UI (UNCHANGED)
            Column(
              children: [
                AppBar(
                  elevation: 0,
                  backgroundColor: Colors.white,
                  title: const Text(
                    "Menu",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  centerTitle: true,
                  iconTheme: const IconThemeData(color: Colors.black),
                ),

                Expanded(
                  child: Column(
                    children: [

                      /// 👤 PROFILE HEADER
                      _animatedFadeSlide(
                        Container(
                          margin: const EdgeInsets.all(16),
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.06),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              const CircleAvatar(
                                radius: 28,
                                backgroundImage: NetworkImage(
                                  "https://randomuser.me/api/portraits/men/32.jpg",
                                ),
                              ),
                              const SizedBox(width: 14),
                              const Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Rahul Sharma",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      "Driver Partner",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              _actionIcon(
                                icon: Icons.call,
                                color: Colors.green,
                                onTap: () {},
                              ),
                              const SizedBox(width: 8),
                              _actionIcon(
                                icon: Icons.message,
                                color: Colors.blue,
                                onTap: () {},
                              ),
                            ],
                          ),
                        ),
                        delay: 0,
                      ),

                      /// 🔹 MENU LIST
                      Expanded(
                        child: ListView(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          children: [
                            _animatedFadeSlide(
                              _menuTile(
                                icon: Icons.person,
                                title: "My Profile",
                                subtitle: "View & edit profile details",
                                iconColor: Colors.indigo,
                                onTap: () {},
                              ),
                              delay: 100,
                            ),
                            _animatedFadeSlide(
                              _menuTile(
                                icon: Icons.account_balance_wallet,
                                title: "Wallet & Earnings",
                                subtitle: "View balance & payouts",
                                iconColor: Colors.green,
                                onTap: () {},
                              ),
                              delay: 200,
                            ),
                            _animatedFadeSlide(
                              _menuTile(
                                icon: Icons.history,
                                title: "Trip History",
                                subtitle: "Your completed rides",
                                iconColor: Colors.blueGrey,
                                onTap: () {},
                              ),
                              delay: 300,
                            ),
                            _animatedFadeSlide(
                              _menuTile(
                                icon: Icons.settings,
                                title: "Settings",
                                subtitle: "App preferences & account",
                                iconColor: Colors.orange,
                                onTap: () {},
                              ),
                              delay: 400,
                            ),
                            _animatedFadeSlide(
                              _menuTile(
                                icon: Icons.help_outline,
                                title: "Help & Support",
                                subtitle: "Get help or contact support",
                                iconColor: Colors.purple,
                                onTap: () {},
                              ),
                              delay: 500,
                            ),
                          ],
                        ),
                      ),

                      /// 🔴 LOGOUT
                      _animatedFadeSlide(
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.redAccent,
                              minimumSize:
                              const Size(double.infinity, 52),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              "Logout",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        delay: 600,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// 🔹 Action Icon
  Widget _actionIcon({
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(30),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: color.withOpacity(0.12),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: color, size: 20),
      ),
    );
  }

  /// 🔹 Menu Tile
  Widget _menuTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color iconColor,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ListTile(
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        leading: Container(
          height: 44,
          width: 44,
          decoration: BoxDecoration(
            color: iconColor.withOpacity(0.15),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: iconColor, size: 24),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 15,
            color: Colors.black,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.black54,
          ),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios_rounded,
          size: 16,
          color: Colors.black38,
        ),
        onTap: onTap,
      ),
    );
  }
}
