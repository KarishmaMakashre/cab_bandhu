import 'package:cab_bandhu/features/porter_partner/screens/portner_verification.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../../../core/constants/color_constants.dart';

class OrderDetailScreen extends StatefulWidget {
  const OrderDetailScreen({super.key});

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen>
    with SingleTickerProviderStateMixin {
  late List<VideoPlayerController> _videoControllers;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _initializeVideos();
    _animationController =
    AnimationController(vsync: this, duration: const Duration(milliseconds: 800))
      ..forward();
  }

  void _initializeVideos() {
    final videoPaths = [
      'assets/goods/video1.mp4',
      'assets/goods/video2.mp4',
      'assets/goods/video3.mp4',
      'assets/goods/video4.mp4',
    ];

    _videoControllers = videoPaths.map((path) {
      final controller = VideoPlayerController.asset(path);
      controller.initialize().then((_) {
        if (mounted) setState(() {});
      });
      return controller;
    }).toList();
  }

  @override
  void dispose() {
    for (final controller in _videoControllers) {
      controller.dispose();
    }
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black87),
        title: const Text(
          'Order Details',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _animatedFadeSlide(_goodsImages()),
            const SizedBox(height: 20),
            _animatedFadeSlide(_goodsInfo(), delay: 100),
            const SizedBox(height: 16),
            _animatedFadeSlide(_description(), delay: 200),
            const SizedBox(height: 20),
            _animatedFadeSlide(_locationCard(), delay: 300),
            const SizedBox(height: 20),
            _animatedFadeSlide(_ownerDetails(), delay: 400),
            const SizedBox(height: 20),
            _animatedFadeSlide(_pickupTime(), delay: 500),
            const SizedBox(height: 20),
            _animatedFadeSlide(_videoSection(), delay: 600),
            const SizedBox(height: 30),
            _animatedFadeSlide(_acceptRejectButtons(context), delay: 700),
          ],
        ),
      ),
    );
  }

  // ------------------ Animation ------------------

  Widget _animatedFadeSlide(Widget child, {int delay = 0}) {
    return FadeTransition(
      opacity: CurvedAnimation(
        parent: _animationController,
        curve: Interval(delay / 1000, 1.0),
      ),
      child: SlideTransition(
        position: Tween(begin: const Offset(0, 0.1), end: Offset.zero)
            .animate(CurvedAnimation(
          parent: _animationController,
          curve: Interval(delay / 1000, 1.0),
        )),
        child: child,
      ),
    );
  }

  // ------------------ UI ------------------

  Widget _goodsImages() {
    final images = [
      'assets/goods/image2.jpg',
      'assets/goods/image3.webp',
      'assets/goods/image2.jpg',
      'assets/goods/image3.webp',
    ];

    return SizedBox(
      height: 160,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: images.length,
        itemBuilder: (_, i) => Container(
          width: 160,
          margin: const EdgeInsets.only(right: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            boxShadow: const [
              BoxShadow(color: Colors.black12, blurRadius: 8),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Image.asset(images[i], fit: BoxFit.cover),
          ),
        ),
      ),
    );
  }

  Widget _goodsInfo() {
    return _card(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _title('Goods Details'),
          const SizedBox(height: 12),
          _infoRow('Height', '4 ft'),
          _infoRow('Width', '3 ft'),
          _infoRow('Weight', '120 kg'),
        ],
      ),
    );
  }

  Widget _description() {
    return _card(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text('Description', style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Text(
            'House shifting goods including bed, table, chairs and kitchen items. Handle with care.',
            style: TextStyle(color: Colors.black54),
          ),
        ],
      ),
    );
  }

  Widget _locationCard() {
    return _card(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text('Locations', style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 12),
          Row(
            children: [
              Icon(Icons.my_location, color: Colors.green),
              SizedBox(width: 8),
              Expanded(child: Text('Vijay Nagar, Indore')),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Icon(Icons.location_on, color: Colors.redAccent),
              SizedBox(width: 8),
              Expanded(child: Text('MP Nagar, Bhopal')),
            ],
          ),
        ],
      ),
    );
  }

  Widget _ownerDetails() {
    return _card(
      Row(
        children: [
          const CircleAvatar(radius: 24, child: Icon(Icons.person)),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Rahul Sharma', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('Goods Owner', style: TextStyle(color: Colors.black54)),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.call, color: Colors.green),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _pickupTime() {
    return _card(
      const Row(
        children: [
          Icon(Icons.access_time, color: Colors.orange),
          SizedBox(width: 10),
          Text('Pickup Time: 22 Dec, 10:30 AM',
              style: TextStyle(fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _videoSection() {
    if (_videoControllers.any((c) => !c.value.isInitialized)) {
      return _card(const Center(child: CircularProgressIndicator()));
    }

    return _card(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _title('Goods Videos (4 Videos)'),
          const SizedBox(height: 12),
          SizedBox(
            height: 180,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _videoControllers.length,
              itemBuilder: (_, i) => _videoItem(_videoControllers[i], i),
            ),
          ),
        ],
      ),
    );
  }

  Widget _videoItem(VideoPlayerController controller, int index) {
    return Container(
      width: 160,
      margin: const EdgeInsets.only(right: 12),
      child: GestureDetector(
        onTap: () {
          setState(() {
            controller.value.isPlaying ? controller.pause() : controller.play();
          });
        },
        child: Stack(
          alignment: Alignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: AspectRatio(
                aspectRatio: controller.value.aspectRatio,
                child: VideoPlayer(controller),
              ),
            ),
            if (!controller.value.isPlaying)
              const Icon(Icons.play_circle_fill, size: 60, color: Colors.white),
          ],
        ),
      ),
    );
  }

  Widget _acceptRejectButtons(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: () => Navigator.pop(context),
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.redAccent,
              side: const BorderSide(color: Colors.redAccent),
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
            child: const Text('Reject'),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => const PickupVerificationMapScreen()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.ridePrimary,
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
            child: const Text('Accept Order'),
          ),
        ),
      ],
    );
  }

  // ------------------ Helpers ------------------

  Widget _card(Widget child) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 10),
        ],
      ),
      child: child,
    );
  }

  Widget _title(String t) =>
      Text(t, style: const TextStyle(fontWeight: FontWeight.bold));

  Widget _infoRow(String t, String v) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(t, style: const TextStyle(color: Colors.black54)),
          Text(v, style: const TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
