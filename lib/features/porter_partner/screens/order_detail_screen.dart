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
        AnimationController(vsync: this, duration: const Duration(milliseconds: 800));
    _animationController.forward();
  }

  void _initializeVideos() {
    final List<String> videoPaths = [
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
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: const Color(0xFF121212),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text('Order Details', style: TextStyle(color: Colors.white)),
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

  Widget _animatedFadeSlide(Widget child, {int delay = 0}) {
    return FadeTransition(
      opacity: CurvedAnimation(
        parent: _animationController,
        curve: Interval(
          delay / 1000,
          1.0,
          curve: Curves.easeOut,
        ),
      ),
      child: SlideTransition(
        position: Tween<Offset>(begin: const Offset(0, 0.1), end: Offset.zero)
            .animate(CurvedAnimation(
          parent: _animationController,
          curve: Interval(delay / 1000, 1.0, curve: Curves.easeOut),
        )),
        child: child,
      ),
    );
  }

  Widget _goodsImages() {
    final List<String> goodsImagePaths = [
      // 'assets/goods/image1.avif',
      'assets/goods/image2.jpg',
      'assets/goods/image3.webp',
      'assets/goods/image2.jpg',
      'assets/goods/image3.webp',

      // 'assets/goods/image4.avif',
    ];

    return SizedBox(
      height: 160,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: goodsImagePaths.length,
        itemBuilder: (context, index) => _imageItem(goodsImagePaths[index], index),
      ),
    );
  }

  Widget _imageItem(String assetPath, int index) {
    // Alternate colors for images' background
    final bgColors = [
      Colors.grey.shade800,
      Colors.yellow.shade700,
      Colors.greenAccent.shade400,
      Colors.blueGrey.shade700
    ];
    return Container(
      width: 160,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: bgColors[index % bgColors.length],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.asset(assetPath, width: 160, height: 160, fit: BoxFit.cover),
      ),
    );
  }

  Widget _goodsInfo() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _cardDecoration(color: Colors.grey.shade900),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Goods Details',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
          const SizedBox(height: 12),
          _infoRow('Height', '4 ft'),
          _infoRow('Width', '3 ft'),
          _infoRow('Weight', '120 kg'),
        ],
      ),
    );
  }

  Widget _description() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _cardDecoration(color: Colors.orange.shade900),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Description', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
          SizedBox(height: 8),
          Text(
            'House shifting goods including bed, table, chairs and kitchen items. Handle with care.',
            style: TextStyle(color: Colors.white70),
          ),
        ],
      ),
    );
  }

  Widget _locationCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _cardDecoration(color: Colors.green.shade900),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text('Locations', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
          SizedBox(height: 12),
          Row(
            children: [
              Icon(Icons.my_location, color: Colors.greenAccent),
              SizedBox(width: 8),
              Expanded(child: Text('Vijay Nagar, Indore', style: TextStyle(color: Colors.white))),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Icon(Icons.location_on, color: Colors.redAccent),
              SizedBox(width: 8),
              Expanded(child: Text('MP Nagar, Bhopal', style: TextStyle(color: Colors.white))),
            ],
          ),
        ],
      ),
    );
  }

  Widget _ownerDetails() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _cardDecoration(color: Colors.grey.shade800),
      child: Row(
        children: [
          const CircleAvatar(radius: 24, child: Icon(Icons.person, color: Colors.white)),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Rahul Sharma', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                Text('Goods Owner', style: TextStyle(color: Colors.white70)),
              ],
            ),
          ),
          IconButton(icon: const Icon(Icons.call, color: Colors.greenAccent), onPressed: () {}),
        ],
      ),
    );
  }

  Widget _pickupTime() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _cardDecoration(color: Colors.blueGrey.shade900),
      child: const Row(
        children: [
          Icon(Icons.access_time, color: Colors.orangeAccent),
          SizedBox(width: 10),
          Text('Pickup Time: 22 Dec, 10:30 AM',
              style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white)),
        ],
      ),
    );
  }

  Widget _videoSection() {
    if (_videoControllers.isEmpty || _videoControllers.every((c) => !c.value.isInitialized)) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: _cardDecoration(color: Colors.grey.shade900),
        child: const Center(child: CircularProgressIndicator()),
      );
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _cardDecoration(color: Colors.grey.shade800),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Goods Videos (4 Videos)',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
          const SizedBox(height: 12),
          SizedBox(
            height: 180,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _videoControllers.length,
              itemBuilder: (context, index) => _videoItem(_videoControllers[index], index),
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
            if (controller.value.isPlaying) controller.pause();
            else controller.play();
          });
        },
        child: Stack(
          alignment: Alignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: AspectRatio(aspectRatio: controller.value.aspectRatio, child: VideoPlayer(controller)),
            ),
            if (!controller.value.isPlaying)
              Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: Colors.black26),
                child: const Icon(Icons.play_circle_fill, size: 64, color: Colors.white),
              ),
            Positioned(
              bottom: 4,
              right: 4,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(color: Colors.black54, borderRadius: BorderRadius.circular(4)),
                child: Text('Video ${index + 1}', style: const TextStyle(color: Colors.white, fontSize: 10)),
              ),
            ),
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
              Navigator.push(context, MaterialPageRoute(builder: (_) => const PickupVerificationMapScreen()));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.greenAccent,
              padding: const EdgeInsets.symmetric(vertical: 14),
              foregroundColor: Colors.black,
            ),
            child: const Text('Accept Order'),
          ),
        ),
      ],
    );
  }

  BoxDecoration _cardDecoration({Color color = Colors.grey}) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade700),
      color: color,
    );
  }

  Widget _infoRow(String t, String v) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(t, style: const TextStyle(color: Colors.white70)),
          Text(v, style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.white)),
        ],
      ),
    );
  }
}
