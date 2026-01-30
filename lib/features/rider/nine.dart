import 'package:cab_bandhu/core/constants/color_constants.dart';
import 'package:cab_bandhu/features/rider/ten.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RatePassengerScreen extends StatefulWidget {
  const RatePassengerScreen({super.key});

  @override
  State<RatePassengerScreen> createState() => _RatePassengerScreenState();
}

class _RatePassengerScreenState extends State<RatePassengerScreen> {
  int rating = 5;
  final TextEditingController feedbackCtrl = TextEditingController();

  final List<String> tags = [
    "Polite",
    "On time",
    "Good location",
    "Late",
    "Wrong pickup",
  ];

  final Set<String> selectedTags = {};

  @override
  void dispose() {
    feedbackCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /// STATUS BAR
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
    );

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          /// 🌄 BACKGROUND IMAGE
          Positioned.fill(
            child: Image.asset(
              "assets/images/backgroundImg.jpeg",
              fit: BoxFit.cover,
            ),
          ),

          /// 🌫 LIGHT OVERLAY
          Positioned.fill(
            child: Container(
              color: Colors.white.withOpacity(0.82),
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                /// 🔒 FIXED HEADER (NOT SCROLLABLE)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Icon(
                          Icons.arrow_back,
                          size: 22.sp,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Text(
                        "Rate Passenger",
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ).animate().fadeIn().slideX(begin: -0.1),
                ),

                /// 🔽 SCROLLABLE CONTENT
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(16.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// 👤 PASSENGER CARD
                        Container(
                          padding: EdgeInsets.all(14.w),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(14.r),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.06),
                                blurRadius: 14,
                                offset: const Offset(0, 6),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 26.r,
                                backgroundImage: const NetworkImage(
                                  "https://randomuser.me/api/portraits/men/32.jpg",
                                ),
                              ),
                              SizedBox(width: 14.w),
                              Text(
                                "Rahul Sharma",
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                        ).animate().fadeIn().slideY(begin: -0.1),

                        SizedBox(height: 24.h),

                        /// ⭐ QUESTION
                        Text(
                          "How was your passenger?",
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),

                        SizedBox(height: 16.h),

                        /// ⭐ RATING STARS
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(5, (i) {
                            return IconButton(
                              icon: Icon(
                                Icons.star,
                                size: 34.sp,
                                color: i < rating
                                    ? AppColors.ridebtn
                                    : Colors.grey.shade400,
                              ),
                              onPressed: () => setState(() {
                                rating = i + 1;
                              }),
                            );
                          }),
                        ),

                        Center(
                          child: Text(
                            "Excellent experience",
                            style: TextStyle(
                              fontSize: 13.sp,
                              color: Colors.black54,
                            ),
                          ),
                        ),

                        SizedBox(height: 20.h),

                        /// 🏷 TAGS
                        Wrap(
                          spacing: 10.w,
                          runSpacing: 10.h,
                          children: tags.map((tag) {
                            final selected = selectedTags.contains(tag);
                            return ChoiceChip(
                              label: Text(tag),
                              selected: selected,
                              onSelected: (_) {
                                setState(() {
                                  selected
                                      ? selectedTags.remove(tag)
                                      : selectedTags.add(tag);
                                });
                              },
                              selectedColor:
                              AppColors.ridePrimary.withOpacity(0.15),
                              labelStyle: TextStyle(
                                fontSize: 13.sp,
                                color: selected
                                    ? AppColors.ridePrimary
                                    : Colors.black87,
                              ),
                              side: BorderSide(
                                color: selected
                                    ? AppColors.ridePrimary
                                    : Colors.grey.shade400,
                              ),
                              backgroundColor: Colors.white,
                            );
                          }).toList(),
                        ),

                        SizedBox(height: 24.h),

                        /// ✍ FEEDBACK
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 12.w),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                          child: TextField(
                            controller: feedbackCtrl,
                            maxLines: 5,
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.black87,
                            ),
                            decoration: InputDecoration(
                              hintText: "Additional feedback (optional)",
                              hintStyle: TextStyle(
                                fontSize: 13.sp,
                                color: Colors.black54,
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        ),

                        SizedBox(height: 20.h),

                        /// 🖼 IMAGE
                        ClipRRect(
                          borderRadius: BorderRadius.circular(14.r),
                          child: Image.network(
                            "https://images.unsplash.com/photo-1520975916090-3105956dac38",
                            height: 0.45.sh,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),

                        SizedBox(height: 90.h),
                      ],
                    ),
                  ),
                ),

                /// 🔘 FIXED BOTTOM BUTTON
                Padding(
                  padding: EdgeInsets.all(16.w),
                  child: SizedBox(
                    width: double.infinity,
                    height: 52.h,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.ridebtn,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14.r),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const EarningsUpdatedScreen(),
                          ),
                        );
                      },
                      child: Text(
                        "Submit Rating",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
