import 'package:flutter/material.dart';

class SkeletonLoader extends StatefulWidget {
  const SkeletonLoader({super.key, this.height = 120, this.width = double.infinity, this.borderRadius = 24});

  final double height;
  final double width;
  final double borderRadius;

  @override
  State<SkeletonLoader> createState() => _SkeletonLoaderState();
}

class _SkeletonLoaderState extends State<SkeletonLoader> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 900),
  )..repeat(reverse: true);

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: Tween<double>(begin: 0.4, end: 0.9).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut)),
      child: Container(
        height: widget.height,
        width: widget.width,
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface.withOpacity(.4),
          borderRadius: BorderRadius.circular(widget.borderRadius),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
