import 'package:cab_bandhu/features/auth/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PartnerTypeBottomSheet extends StatefulWidget {
  const PartnerTypeBottomSheet({super.key});

  @override
  State<PartnerTypeBottomSheet> createState() =>
      _PartnerTypeBottomSheetState();
}

class _PartnerTypeBottomSheetState extends State<PartnerTypeBottomSheet> {
  String selected = 'rider';

  final List<Map<String, dynamic>> partners = [
    {
      'id': 'rider',
      'title': 'Rider Partner',
      'subtitle': 'Drive with Cab Bandhu',
      'icon': Icons.directions_car,
      'color': Color(0xffF5C542),
    },
    {
      'id': 'porter',
      'title': 'Porter Partner',
      'subtitle': 'Deliver with Cab Bandhu',
      'icon': Icons.local_shipping,
      'color': Color(0xff43A047),
    },
    {
      'id': 'intercity',
      'title': 'Intercity Cab',
      'subtitle': 'Outstation rides',
      'icon': Icons.moped,
      'color': Color(0xffFF8A65),
    },
  ];

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;

    return Container(
      height: h * 0.6,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        image: DecorationImage(
          image: AssetImage('assets/images/backgroundImg.jpeg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        // ✅ light white overlay
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
          color: Colors.white.withOpacity(0.85),
        ),
        child: Column(
          children: [
            // Drag handle
            Container(
              margin: const EdgeInsets.only(top: 12),
              height: 5,
              width: 50,
              decoration: BoxDecoration(
                color: Colors.grey.shade400,
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
                        color: Colors.black,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.black54),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Select how you want to earn with Cab Bandhu',
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
            ),

            const SizedBox(height: 20),

            // Partner cards
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: partners.length,
                itemBuilder: (_, i) {
                  final item = partners[i];
                  final isSelected = selected == item['id'];
                  final cardColor = item['color'] as Color;

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
                          builder: (_) => const RegistrationScreen(),
                        ),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: isSelected
                              ? cardColor
                              : Colors.grey.shade300,
                          width: isSelected ? 2 : 1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 6,
                            offset: Offset(0, 3),
                          )
                        ],
                      ),
                      child: Row(
                        children: [
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              color: cardColor.withOpacity(0.15),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              item['icon'],
                              color: cardColor,
                              size: 26,
                            ),
                          ),
                          const SizedBox(width: 16),

                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item['title'],
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  item['subtitle'],
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.black54,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Icon(
                            isSelected
                                ? Icons.check_circle
                                : Icons.circle_outlined,
                            color: isSelected
                                ? cardColor
                                : Colors.grey,
                          ),
                        ],
                      ),
                    )
                        .animate()
                        .fade(duration: 400.ms)
                        .slideX(begin: 0.2),
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
