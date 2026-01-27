import 'package:flutter/material.dart';
import 'package:cab_bandhu/features/auth/screens/role_selection_screen.dart';

class BottomNavScreen extends StatefulWidget {
  const BottomNavScreen({super.key});

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {

  @override
  void initState() {
    super.initState();

    // Screen open hone ke baad bottom sheet open ho
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _openPartnerSheet();
    });
  }

  void _openPartnerSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      enableDrag: true,
      builder: (_) => const PartnerTypeBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SizedBox.shrink(), // blank background
    );
  }
}
