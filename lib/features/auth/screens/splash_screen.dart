import 'package:cab_bandhu/features/auth/screens/role_selection_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  final PageController _pageController = PageController();
  int currentIndex = 0;

  late AnimationController _animationController;
  late Animation<double> _fade;
  late Animation<Offset> _slide;
  late Animation<double> _scale;

  static const String rideLottie =
      "https://lottie.host/f07d1385-af5c-4adb-bdbd-c9b522d4691e/IaKyKEpczU.json";
  static const String trackingLottie =
      "https://lottie.host/b008461f-f018-4dc2-9699-56580d8c0254/ntTdDeFRft.json";
  static const String secureLottie =
      "https://lottie.host/f670f3e6-4a67-462f-8760-e2093b9999ff/LCqcyzpYZ9.json";

  final List<_SplashData> splashData = [
    _SplashData(
      title: "Book Your Ride",
      subtitle:
      "Experience fast, easy, and reliable cab booking anytime, anywhere, designed to make every ride effortless.",
      lottieUrl: rideLottie,
    ),
    _SplashData(
      title: "Live Tracking",
      subtitle:
      "Track your driver in real time with accurate location updates, so you always know exactly where your ride is.",
      lottieUrl: trackingLottie,
    ),
    _SplashData(
      title: "Safe & Secure",
      subtitle:
      "Your safety is our top priority, and we ensure a secure and comfortable experience on every ride you take.",
      lottieUrl: secureLottie,
    ),
  ];

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    _fade = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    );

    _slide = Tween<Offset>(
      begin: const Offset(0, 0.15),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    _scale = Tween<double>(
      begin: 0.95,
      end: 1,
    ).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    _animationController.forward();
  }

  void nextPage() {
    if (currentIndex < splashData.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) => const PartnerTypeBottomSheet(),
      );
    }
  }


  @override
  void dispose() {
    _animationController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xffFFF7E0),
              Colors.white,
            ],
          ),
        ),
        child: Stack(
          children: [
            SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: splashData.length,
                      onPageChanged: (index) {
                        setState(() => currentIndex = index);
                        _animationController
                          ..reset()
                          ..forward();
                      },
                      itemBuilder: (context, index) {
                        final item = splashData[index];

                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FadeTransition(
                              opacity: _fade,
                              child: ScaleTransition(
                                scale: _scale,
                                child: Lottie.network(
                                  item.lottieUrl,
                                  height: 260.h,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),

                            SizedBox(height: 40.h),

                            SlideTransition(
                              position: _slide,
                              child: FadeTransition(
                                opacity: _fade,
                                child: Column(
                                  children: [
                                    Text(
                                      item.title,
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.inter(
                                        fontSize: 28.sp,
                                        fontWeight: FontWeight.w700,
                                        color: const Color(0xffF5C542),
                                      ),
                                    ),
                                    SizedBox(height: 12.h),
                                    Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 36.w),
                                      child: Text(
                                        item.subtitle,
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.inter(
                                          fontSize: 14.sp,
                                          height: 1.5,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.grey.shade600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      splashData.length,
                          (index) => _dot(index == currentIndex),
                    ),
                  ),

                  SizedBox(height: 32.h),

                  GestureDetector(
                    onTap: nextPage,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      height: 56.h,
                      width: currentIndex == splashData.length - 1
                          ? 180.w
                          : 130.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.r),
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xff90EE90),
                            Color(0xff1CB51C),
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.15),
                            blurRadius: 18,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          currentIndex == splashData.length - 1
                              ? "Get Started"
                              : "Next",
                          style: GoogleFonts.inter(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 30.h),
                ],
              ),
            ),

            const CornerSkipButton(),
          ],
        ),
      ),
    );
  }

  Widget _dot(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      margin: EdgeInsets.symmetric(horizontal: 5.w),
      height: 6.h,
      width: isActive ? 20.w : 6.w,
      decoration: BoxDecoration(
        color: isActive ? const Color(0xffF5C542) : Colors.grey.shade300,
        borderRadius: BorderRadius.circular(12.r),
      ),
    );
  }
}

/// =======================
/// DATA MODEL
/// =======================
class _SplashData {
  final String title;
  final String subtitle;
  final String lottieUrl;

  _SplashData({
    required this.title,
    required this.subtitle,
    required this.lottieUrl,
  });
}

/// =======================
/// SKIP BUTTON
/// =======================
class CornerSkipButton extends StatelessWidget {
  const CornerSkipButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).padding.top + 6,
      right: 0,
      child: GestureDetector(
        onTap: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (context) => const PartnerTypeBottomSheet(),
          );
        },

        child: Container(
          height: 54,
          width: 110,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Color(0xff90EE90),
                Color(0xff1CB51C),
              ],
            ),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(40),
              bottomLeft: Radius.circular(40),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.18),
                blurRadius: 16,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          alignment: Alignment.center,
          child: Text(
            "Skip",
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}


class TopRightCircularClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    // start from top-right
    path.moveTo(size.width, 0);

    // go down
    path.lineTo(size.width, size.height);

    // circular arc curve
    path.arcToPoint(
      Offset(0, 0),
      radius: Radius.circular(size.width * 1.2),
      clockwise: false,
    );

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

/// =======================
/// CLIPPER
/// =======================
class TopRightQuarterCircleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.arcToPoint(
      Offset(size.width, 0),
      radius: Radius.circular(size.width),
      clockwise: true,
    );
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
