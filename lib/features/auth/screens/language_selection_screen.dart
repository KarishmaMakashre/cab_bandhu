import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/color_constants.dart';
import 'bottom_navigation_bar.dart';

class LanguageSelectionScreen extends StatefulWidget {
  const LanguageSelectionScreen({super.key});

  @override
  State<LanguageSelectionScreen> createState() =>
      _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends State<LanguageSelectionScreen> {
  String _selectedLanguage = 'en';

  final List<Map<String, String>> _languages = [
    {'code': 'en', 'name': 'English', 'script': 'English'},
    {'code': 'te', 'name': 'Telugu', 'script': 'తెలుగు'},
    {'code': 'hi', 'name': 'Hindi', 'script': 'हिंदी'},
    {'code': 'ta', 'name': 'Tamil', 'script': 'தமிழ்'},
    {'code': 'kn', 'name': 'Kannada', 'script': 'ಕನ್ನಡ'},
    {'code': 'ml', 'name': 'Malayalam', 'script': 'മലയാളം'},
    {'code': 'pa', 'name': 'Punjabi', 'script': 'ਪੰਜਾਬੀ'},
  ];

  void _showAddLanguageDialog() {
    final nameController = TextEditingController();
    final scriptController = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: const Text("Add Language"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration:
              const InputDecoration(labelText: "Language Name"),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: scriptController,
              decoration:
              const InputDecoration(labelText: "Language Script"),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.brownPrimary,
            ),
            onPressed: () {
              if (nameController.text.isEmpty ||
                  scriptController.text.isEmpty) return;

              setState(() {
                final code =
                nameController.text.toLowerCase().substring(0, 2);
                _languages.add({
                  'code': code,
                  'name': nameController.text,
                  'script': scriptController.text,
                });
                _selectedLanguage = code;
              });

              Navigator.pop(context);
            },
            child: const Text("Add"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          /// 🌄 BACKGROUND IMAGE
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSSXIXtIUUQHSI5SWYvD9a830k84jiX23Yplw&s',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),


          /// 🌑 OVERLAY
          Container(color: Colors.black.withOpacity(0.6)),

          SafeArea(
            child: Column(
              children: [
                /// 🔙 APP BAR
                Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () => context.pop(),
                        icon: const Icon(Icons.arrow_back,
                            color: Colors.white),
                      ),
                      const SizedBox(width: 8),
                      const Expanded(
                        child: Text(
                          'Select a language',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                /// 🌐 GRID
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: GridView.builder(
                      itemCount: _languages.length + 1,
                      gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1.8,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                      ),
                      itemBuilder: (context, index) {
                        /// ➕ ADD LANGUAGE
                        if (index == _languages.length) {
                          return GestureDetector(
                            onTap: _showAddLanguageDialog,
                            child: _glassCard(
                              child: const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.add_circle_outline,
                                      color: Colors.white, size: 32),
                                  SizedBox(height: 8),
                                  Text(
                                    "Add Language",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }

                        final lang = _languages[index];
                        final isSelected =
                            _selectedLanguage == lang['code'];

                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedLanguage = lang['code']!;
                            });
                          },
                          child: _glassCard(
                            borderColor: isSelected
                                ? AppColors.brownPrimary
                                : Colors.white30,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  lang['script']!,
                                  style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  lang['name']!,
                                  style: const TextStyle(
                                    color: Colors.white70,
                                  ),
                                ),
                                if (isSelected)
                                  const Padding(
                                    padding: EdgeInsets.only(top: 6),
                                    child: Icon(Icons.check_circle,
                                        color: AppColors.ridePrimary),
                                  )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),

                /// ✅ CONFIRM BUTTON
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) => BottomNavScreen(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.ridePrimary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text(
                        'Confirm',
                        style: TextStyle(
                          fontSize: 16,
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

  /// 🧊 GLASS CARD WIDGET
  Widget _glassCard({required Widget child, Color? borderColor}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.12),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderColor ?? Colors.white24),
      ),
      child: child,
    );
  }
}
