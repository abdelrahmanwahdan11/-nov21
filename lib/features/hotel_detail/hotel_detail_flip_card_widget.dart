import 'dart:math';

import 'package:flutter/material.dart';

import '../../models/hotel.dart';

class HotelDetailFlipCardWidget extends StatefulWidget {
  const HotelDetailFlipCardWidget({super.key, required this.hotel});

  final Hotel hotel;

  @override
  State<HotelDetailFlipCardWidget> createState() => _HotelDetailFlipCardWidgetState();
}

class _HotelDetailFlipCardWidgetState extends State<HotelDetailFlipCardWidget> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(duration: const Duration(milliseconds: 600), vsync: this);
  bool _showFront = true;

  void _toggle() {
    if (_showFront) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
    _showFront = !_showFront;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggle,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          final angle = _controller.value * pi;
          return Transform(
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateY(angle),
            alignment: Alignment.center,
            child: _controller.value < 0.5 ? _buildFront(context) : _buildBack(context),
          );
        },
      ),
    );
  }

  Widget _buildFront(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Atmosphere', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          Text('Botanical suites · Calming palette · Smart concierge'),
        ],
      ),
    );
  }

  Widget _buildBack(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withOpacity(.15),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('AI tips', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          Text('${widget.hotel.name} pairs well with dune dinners and sunrise yoga. Best rates mid-week.'),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
