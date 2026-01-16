import 'package:flutter/material.dart';
import 'package:cab_bandhu/features/auth/screens/role_selection_screen.dart';

import 'FavoriteTripsScreen.dart';
import 'IntercityRidePorterScreen.dart';

class BottomNavScreen extends StatefulWidget {
  const BottomNavScreen({super.key});

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  int _currentIndex = 1; // default = Search

  void _openPartnerSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const PartnerTypeBottomSheet(),
    );
  }

  Widget _getScreen() {
    switch (_currentIndex) {
      case 1:
        return const FavoriteTripsScreen(); // 🔍 Search
      case 2:
        return const IntercityRidePorterScreen(); // 👤 Profile
      default:
        return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getScreen(),

      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,

        /// 🎨 COLOR CHANGE HERE
        selectedItemColor: const Color(0xffF5C542), // yellow
        unselectedItemColor: Colors.grey,

        selectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.bold,
        ),

        onTap: (index) {
          if (index == 0) {
            _openPartnerSheet(); // Switch
          } else {
            setState(() {
              _currentIndex = index;
            });
          }
        },

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.switch_access_shortcut),
            label: 'Switch',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            label: 'like',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'search',
          ),
        ],
      ),
    );
  }
}
