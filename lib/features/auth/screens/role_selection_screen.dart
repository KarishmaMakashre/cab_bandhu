import 'package:cab_bandhu/features/auth/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Intercity_input/driver_dashboard_screen.dart';

class PartnerTypeBottomSheet extends StatefulWidget {
  const PartnerTypeBottomSheet({super.key});

  @override
  State<PartnerTypeBottomSheet> createState() => _PartnerTypeBottomSheetState();
}

class _PartnerTypeBottomSheetState extends State<PartnerTypeBottomSheet> {
  String selected = 'rider';

  final List<Map<String, dynamic>> partners = [
    {
      'id': 'rider',
      'title': 'Rider Partner',
      'subtitle': 'Drive with TRYDE',
      'icon': Icons.directions_car,
      'color': Color(0xffF5C542), // Gold
    },
    {
      'id': 'porter',
      'title': 'Porter Partner',
      'subtitle': 'Deliver with TRYDE',
      'icon': Icons.local_shipping,
      'color': Color(0xff43A047), // Green
    },
    {
      'id': 'intercity',
      'title': 'Intercity Cab',
      'subtitle': 'Outstation rides',
      'icon': Icons.moped,
      'color': Color(0xffFF8A65), // Orange
    },
  ];

  final String bgImageUrl =
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSSXIXtIUUQHSI5SWYvD9a830k84jiX23Yplw&s';

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;

    return Container(
      height: h * 0.6,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
        image: DecorationImage(
          image: NetworkImage(bgImageUrl),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        // Dark overlay for readability
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
          color: Colors.black.withOpacity(0.55),
        ),
        child: Column(
          children: [
            // Drag handle
            Container(
              margin: const EdgeInsets.only(top: 12),
              height: 5,
              width: 50,
              decoration: BoxDecoration(
                color: Colors.white54,
                borderRadius: BorderRadius.circular(12),
              ),
            ),

            const SizedBox(height: 16),

            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Choose Partner Type',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.white70),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 8),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Select how you want to earn with TRYDE',
                style: TextStyle(fontSize: 14, color: Colors.white60),
              ),
            ),

            const SizedBox(height: 20),

            // Partner Cards
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: partners.length,
                itemBuilder: (_, i) {
                  final item = partners[i];
                  final isSelected = selected == item['id'];

                  // Safe color handling
                  final cardColor = (item['color'] as Color?) ?? Colors.white;

                  return GestureDetector(
                    onTap: () async {
                      setState(() => selected = item['id']);

                      final prefs = await SharedPreferences.getInstance();
                      await prefs.setString('user_role', item['id']);

                      await Future.delayed(const Duration(milliseconds: 250));

                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const DriverDashboardScreen(),
                        ),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? cardColor.withOpacity(0.2)
                            : Colors.white10,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          // Icon with colored circle
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              color: cardColor.withOpacity(0.2),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              item['icon'],
                              color: cardColor,
                              size: 26,
                            ),
                          ),
                          const SizedBox(width: 16),

                          // Text
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item['title'],
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  item['subtitle'],
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.white70,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Selection check
                          AnimatedSwitcher(
                            duration: const Duration(milliseconds: 300),
                            child: isSelected
                                ? Icon(Icons.check_circle,
                                key: const ValueKey('selected'),
                                color: cardColor)
                                : const Icon(Icons.circle_outlined,
                                key: ValueKey('unselected'),
                                color: Colors.white70),
                          ),
                        ],
                      ),
                    ).animate().fade(duration: 500.ms).slideX(begin: 0.3),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
