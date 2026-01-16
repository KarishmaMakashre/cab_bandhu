import 'package:cab_bandhu/features/rider/ten.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

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
    final w = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFF121212), // Dark background
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    /// 🔙 Back + Title
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: const Icon(Icons.arrow_back, color: Colors.white),
                        ),
                        const SizedBox(width: 12),
                        const Text(
                          "Rate Passenger",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ).animate().fadeIn(duration: 400.ms).slideX(begin: -0.1),

                    const SizedBox(height: 24),

                    /// 👤 Passenger Card
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Row(
                        children: const [
                          CircleAvatar(
                            radius: 26,
                            backgroundImage: NetworkImage(
                              "https://randomuser.me/api/portraits/men/32.jpg",
                            ),
                          ),
                          SizedBox(width: 14),
                          Text(
                            "Rahul Sharma",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ).animate().fadeIn(duration: 400.ms).slideY(begin: -0.1),

                    const SizedBox(height: 24),

                    /// ⭐ Question
                    const Text(
                      "How was your passenger?",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ).animate().fadeIn(duration: 400.ms).slideX(begin: -0.1),

                    const SizedBox(height: 16),

                    /// ⭐ Rating Stars
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(5, (i) {
                        return IconButton(
                          icon: Icon(
                            Icons.star,
                            size: 36,
                            color: i < rating
                                ? Colors.orange
                                : Colors.grey.shade700,
                          ),
                          onPressed: () => setState(() => rating = i + 1),
                        );
                      }),
                    ).animate().fadeIn(duration: 400.ms).slideY(begin: -0.1),

                    const Center(
                      child: Text(
                        "Excellent experience",
                        style: TextStyle(color: Colors.white70),
                      ),
                    ).animate().fadeIn(duration: 400.ms).slideY(begin: -0.1),

                    const SizedBox(height: 20),

                    /// 🏷 Feedback Chips
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
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
                          selectedColor: Colors.green.withOpacity(.15),
                          labelStyle: TextStyle(
                            color: selected ? Colors.green : Colors.black,
                          ),
                          side: BorderSide(
                            color: selected
                                ? Colors.green
                                : Colors.grey.shade400,
                          ),
                          backgroundColor: Colors.grey.shade100,
                        );
                      }).toList(),
                    ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.1),

                    const SizedBox(height: 24),

                    /// ✍ Feedback Field
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.shade400),
                      ),
                      child: TextField(
                        controller: feedbackCtrl,
                        maxLines: 5,
                        style: const TextStyle(color: Colors.black),
                        decoration: const InputDecoration(
                          hintText: "Additional feedback (optional)",
                          hintStyle: TextStyle(color: Colors.black54),
                          border: InputBorder.none,
                        ),
                      ),
                    ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.1),

                    const SizedBox(height: 20),

                    /// 🖼 Image
                    ClipRRect(
                      borderRadius: BorderRadius.circular(14),
                      child: Image.network(
                        "https://images.unsplash.com/photo-1520975916090-3105956dac38",
                        height: w * 0.45,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.1),

                    const SizedBox(height: 80), // space for button
                  ],
                ),
              ),
            ),

            /// ✅ Fixed Bottom Button
            Padding(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.greenAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
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
                  child: const Text(
                    "Submit Rating",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
