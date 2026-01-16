import 'package:flutter/material.dart';
import 'language_selection_screen.dart';

class OnboardingRideScreen extends StatefulWidget {
  const OnboardingRideScreen({super.key});

  @override
  State<OnboardingRideScreen> createState() => _OnboardingRideScreenState();
}

class _OnboardingRideScreenState extends State<OnboardingRideScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> leftCarAnim;
  late Animation<double> rightCarAnim;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();

    leftCarAnim = Tween<double>(
      begin: -100,
      end: 520,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.linear),
    );

    rightCarAnim = Tween<double>(
      begin: -100,
      end: 520,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.linear),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(28),
            child: Stack(
              children: [
                // Road Background
                Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/road.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                // Dark Overlay
                Container(color: Colors.black.withOpacity(0.55)),

                // Left lane car (Top → Bottom)
                AnimatedBuilder(
                  animation: leftCarAnim,
                  builder: (context, child) {
                    return Positioned(
                      top: leftCarAnim.value,
                      left: width * 0.25,
                      child: child!,
                    );
                  },
                  child: Image.asset(
                    'assets/images/car.png',
                    height: 70,
                  ),
                ),

                // Right lane car (Bottom → Top)
                AnimatedBuilder(
                  animation: rightCarAnim,
                  builder: (context, child) {
                    return Positioned(
                      bottom: rightCarAnim.value,
                      right: width * 0.25,
                      child: child!,
                    );
                  },
                  child: Transform.rotate(
                    angle: 3.14,
                    child: Image.asset(
                      'assets/images/car.png',
                      height: 70,
                    ),
                  ),
                ),

                // Text + Button
                Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                  child: Column(
                    children: [
                      const Spacer(),

                      const Text(
                        "Making Your\nRide Enjoyable",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Color(0xffF5C542),
                        ),
                      ),

                      const SizedBox(height: 12),

                      const Text(
                        "Expert drivers at work, we will pick you\nin less time from your exact location",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),

                      const SizedBox(height: 28),

                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            PageRouteBuilder(
                              transitionDuration:
                              const Duration(milliseconds: 600),
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                              const LanguageSelectionScreen(),
                              transitionsBuilder: (context, animation,
                                  secondaryAnimation, child) {
                                final slide = Tween<Offset>(
                                  begin: const Offset(1, 0),
                                  end: Offset.zero,
                                ).animate(
                                  CurvedAnimation(
                                    parent: animation,
                                    curve: Curves.easeOutCubic,
                                  ),
                                );

                                final fade = Tween<double>(
                                  begin: 0,
                                  end: 1,
                                ).animate(animation);

                                return SlideTransition(
                                  position: slide,
                                  child: FadeTransition(
                                    opacity: fade,
                                    child: child,
                                  ),
                                );
                              },
                            ),
                          );
                        },
                        child: Container(
                          height: 56,
                          width: 56,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Color(0xffF5C542),
                              width: 2,
                            ),
                          ),
                          child: const Icon(
                            Icons.arrow_forward_sharp,
                            color: Color(0xffF5C542),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
