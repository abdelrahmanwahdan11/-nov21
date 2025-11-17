import 'dart:math';

import 'package:flutter/material.dart';

import '../../models/hotel.dart';

class Featured3DCarousel extends StatefulWidget {
  const Featured3DCarousel({super.key, required this.hotels});

  final List<Hotel> hotels;

  @override
  State<Featured3DCarousel> createState() => _Featured3DCarouselState();
}

class _Featured3DCarouselState extends State<Featured3DCarousel> {
  final PageController _controller = PageController(viewportFraction: 0.78);
  double _page = 0;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() => _page = _controller.page ?? 0);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.hotels.isEmpty) return const SizedBox.shrink();
    return SizedBox(
      height: 260,
      child: PageView.builder(
        controller: _controller,
        itemCount: widget.hotels.length,
        itemBuilder: (context, index) {
          final hotel = widget.hotels[index];
          final delta = index - _page;
          final rotation = delta.clamp(-1, 1).toDouble();
          final scale = 1 - rotation.abs() * 0.1;
          return Transform(
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateY(rotation * pi / 12)
              ..scale(scale),
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(32),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(hotel.image, fit: BoxFit.cover),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [Colors.black.withOpacity(0.65), Colors.transparent],
                        ),
                      ),
                    ),
                    Positioned(
                      left: 20,
                      right: 20,
                      bottom: 24,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            hotel.name,
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            '${hotel.city} · ${hotel.price.toStringAsFixed(0)} / night',
                            style: const TextStyle(color: Colors.white70),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
