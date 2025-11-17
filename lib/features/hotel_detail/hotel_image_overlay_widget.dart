import 'package:flutter/material.dart';

import '../../models/hotel.dart';

class HotelImageOverlayWidget extends StatefulWidget {
  const HotelImageOverlayWidget({super.key, required this.hotel, required this.onClose});

  final Hotel hotel;
  final VoidCallback onClose;

  @override
  State<HotelImageOverlayWidget> createState() => _HotelImageOverlayWidgetState();
}

class _HotelImageOverlayWidgetState extends State<HotelImageOverlayWidget> {
  bool _flipped = false;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Stack(
        children: [
          GestureDetector(
            onTap: widget.onClose,
            onVerticalDragEnd: (_) => widget.onClose(),
            child: Container(color: Colors.black54),
          ),
          Center(
            child: GestureDetector(
              onTap: () => setState(() => _flipped = !_flipped),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                transitionBuilder: (child, animation) {
                  final rotate = Tween(begin: _flipped ? -1.0 : 1.0, end: 0.0).animate(animation);
                  return AnimatedBuilder(
                    animation: rotate,
                    child: child,
                    builder: (context, child) {
                      final angle = rotate.value * 3.1416;
                      return Transform(
                        transform: Matrix4.identity()
                          ..setEntry(3, 2, 0.001)
                          ..rotateY(angle),
                        alignment: Alignment.center,
                        child: child,
                      );
                    },
                  );
                },
                child: _flipped ? _buildBack(context) : _buildFront(context),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFront(BuildContext context) {
    return ClipRRect(
      key: const ValueKey('front'),
      borderRadius: BorderRadius.circular(32),
      child: Stack(
        children: [
          Image.network(widget.hotel.image, width: MediaQuery.of(context).size.width * 0.8, fit: BoxFit.cover),
          Positioned(
            left: 24,
            bottom: 24,
            right: 24,
            child: Text(
              widget.hotel.name,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBack(BuildContext context) {
    return Container(
      key: const ValueKey('back'),
      width: MediaQuery.of(context).size.width * 0.8,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(32),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Highlights', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 12),
          ...widget.hotel.amenities.map((a) => ListTile(
                dense: true,
                leading: const Icon(Icons.check_circle_outline),
                title: Text(a),
              )),
          const SizedBox(height: 12),
          TextButton(onPressed: widget.onClose, child: const Text('Close')),
        ],
      ),
    );
  }
}
