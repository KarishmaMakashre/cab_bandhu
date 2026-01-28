import 'package:flutter/material.dart';

class TopHeaderIntercity extends StatelessWidget {
  final String userName;
  final String location;
  final bool isOnline;
  final ValueChanged<bool> onStatusChanged;
  final VoidCallback? onNotificationTap;

  const TopHeaderIntercity({
    super.key,
    required this.userName,
    required this.location,
    required this.isOnline,
    required this.onStatusChanged,
    this.onNotificationTap,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFFFB300),
              Color(0xFFFFE082),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(color: Colors.black26, blurRadius: 6),
          ],
        ),
        child: Row(
          children: [
            /// 👤 PROFILE
            const CircleAvatar(
              radius: 22,
              backgroundImage: NetworkImage(
                'https://i.imgur.com/QCNbOAo.png',
              ),
            ),

            const SizedBox(width: 12),

            /// 👋 TEXT
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text('Welcome ',
                          style: TextStyle(fontSize: 13)),
                      const Icon(Icons.waving_hand,
                          size: 14, color: Colors.orange),
                      const SizedBox(width: 4),
                      Text(
                        userName,
                        style: const TextStyle(
                            fontSize: 13, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      const Icon(Icons.location_on, size: 14),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          location,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            /// 🔘 ANIMATED ON/OFF TOGGLE
            GestureDetector(
              onTap: () => onStatusChanged(!isOnline),
              child: AnimatedScale(
                scale: isOnline ? 1.05 : 1.0,
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeOutBack,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  width: 66,
                  height: 30,
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    color: isOnline ? Colors.green : Colors.red,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: isOnline
                            ? Colors.green.withOpacity(0.6)
                            : Colors.red.withOpacity(0.6),
                        blurRadius: isOnline ? 10 : 4,
                        spreadRadius: isOnline ? 1 : 0,
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      /// TEXT INSIDE
                      Align(
                        alignment: isOnline
                            ? Alignment.centerLeft
                            : Alignment.centerRight,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 200),
                            child: Text(
                              isOnline ? 'ON' : 'OFF',
                              key: ValueKey(isOnline),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),

                      /// THUMB
                      AnimatedAlign(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        alignment: isOnline
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Container(
                          width: 22,
                          height: 22,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(width: 6),

            /// 🔔 NOTIFICATION
            Stack(
              children: [
                IconButton(
                  icon: const Icon(Icons.notifications_none),
                  onPressed: onNotificationTap,
                ),
                Positioned(
                  right: 6,
                  top: 6,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
