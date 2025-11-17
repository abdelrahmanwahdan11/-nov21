import 'dart:math';
import 'package:flutter/material.dart';
import '../../models/hotel.dart';

class HotelImageOverlayWidget extends StatefulWidget {
  const HotelImageOverlayWidget({super.key, required this.hotel});
  final Hotel hotel;

  @override
  State<HotelImageOverlayWidget> createState() => _HotelImageOverlayWidgetState();
}

class _HotelImageOverlayWidgetState extends State<HotelImageOverlayWidget> {
  bool flipped = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() => flipped = !flipped),
      child: Scaffold(
        backgroundColor: Colors.black.withOpacity(0.8),
        body: Center(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 400),
            transitionBuilder: (child, anim) => AnimatedBuilder(
              animation: anim,
              builder: (_, __) => Transform(
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.001)
                  ..rotateY(pi * anim.value),
                alignment: Alignment.center,
                child: child,
              ),
            ),
            child: flipped
                ? _BackCard(key: const ValueKey('back'), hotel: widget.hotel)
                : _FrontCard(key: const ValueKey('front'), hotel: widget.hotel),
          ),
        ),
      ),
    );
  }
}

class _FrontCard extends StatelessWidget {
  const _FrontCard({super.key, required this.hotel});
  final Hotel hotel;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: Stack(
        children: [
          Image.network(hotel.image, height: 320, width: 320, fit: BoxFit.cover),
          Positioned(bottom: 12, left: 12, child: Text(hotel.name, style: const TextStyle(color: Colors.white, fontSize: 20))),
        ],
      ),
    );
  }
}

class _BackCard extends StatelessWidget {
  const _BackCard({super.key, required this.hotel});
  final Hotel hotel;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      height: 320,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(24)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('About ${hotel.name}', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 12),
          Text(hotel.description),
          const Spacer(),
          Text('Amenities: ${hotel.amenities.join(', ')}'),
        ],
      ),
    );
  }
}
