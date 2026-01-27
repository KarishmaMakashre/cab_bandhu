import 'package:flutter/material.dart';

import '../settings/screens/notification_screen.dart';
import 'driver_menu_screen.dart';

class CustomHomeAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final Function(bool)? onDutyChanged;

  const CustomHomeAppBar({super.key, this.onDutyChanged});

  @override
  Size get preferredSize => const Size.fromHeight(70);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: 70,
        padding: const EdgeInsets.symmetric(horizontal: 14),
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, 2),
            )
          ],
        ),
        child: Row(
          children: [

            /// 👤 PROFILE + LOCATION
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const DriverMenuScreen(),
                  ),
                );
              },
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(
                      "https://images.unsplash.com/photo-1619895862022-09114b41f16f",
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Welcome 👋",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.black54,
                        ),
                      ),
                      Text(
                        "Ratanlok Colony, Indore",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const Spacer(),

            /// 🔄 WHITE THEME DUTY SWITCH
            DutySwitch(
              initialValue: true,
              onChanged: onDutyChanged,
            ),

            const SizedBox(width: 10),

            /// 🔔 NOTIFICATION
            Stack(
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.notifications_none_rounded,
                    size: 30,
                    color: Colors.black54,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const NotificationScreen(),
                      ),
                    );
                  },
                ),
                Positioned(
                  right: 6,
                  top: 6,
                  child: Container(
                    height: 10,
                    width: 10,
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

class DutySwitch extends StatefulWidget {
  final ValueChanged<bool>? onChanged;
  final bool initialValue;

  const DutySwitch({
    super.key,
    this.onChanged,
    this.initialValue = true,
  });

  @override
  State<DutySwitch> createState() => _DutySwitchState();
}

class _DutySwitchState extends State<DutySwitch> {
  late bool isOnDuty;

  @override
  void initState() {
    super.initState();
    isOnDuty = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() => isOnDuty = !isOnDuty);
        widget.onChanged?.call(isOnDuty);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        height: 36,
        width: 80,
        padding: const EdgeInsets.symmetric(horizontal: 6),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [

            /// ON / OFF TEXT
            AnimatedAlign(
              duration: const Duration(milliseconds: 250),
              alignment: isOnDuty
                  ? Alignment.centerLeft
                  : Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  isOnDuty ? "ON" : "OFF",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: isOnDuty
                        ? Colors.green
                        : Colors.redAccent,
                  ),
                ),
              ),
            ),

            /// SLIDER THUMB
            AnimatedAlign(
              duration: const Duration(milliseconds: 250),
              alignment: isOnDuty
                  ? Alignment.centerRight
                  : Alignment.centerLeft,
              child: Container(
                height: 24,
                width: 24,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
