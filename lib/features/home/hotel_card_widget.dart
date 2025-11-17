import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:iconly/iconly.dart';

import '../../core/widgets/skeleton_loader.dart';
import '../../models/hotel.dart';

class HotelCardWidget extends StatelessWidget {
  const HotelCardWidget({
    super.key,
    required this.hotel,
    required this.onTap,
    required this.onAiInfo,
    required this.onToggleCompare,
    required this.isInComparison,
  });

  final Hotel hotel;
  final VoidCallback onTap;
  final VoidCallback onAiInfo;
  final VoidCallback onToggleCompare;
  final bool isInComparison;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Material(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(28),
        child: InkWell(
          borderRadius: BorderRadius.circular(28),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Hero(
                  tag: hotel.id,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: Image.network(
                      hotel.image,
                      height: 120,
                      width: 120,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, progress) =>
                          progress == null ? child : const SkeletonLoader(height: 120, width: 120),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        hotel.name,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 6),
                      Text('${hotel.city} · ${hotel.distance}km · ⭐️${hotel.rating}'),
                      const SizedBox(height: 8),
                      Text('${hotel.price.toStringAsFixed(0)} AED / night',
                          style: Theme.of(context).textTheme.titleMedium),
                      Wrap(
                        spacing: 6,
                        children: hotel.tags.take(3).map((e) => Chip(label: Text(e))).toList(),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          IconButton(onPressed: onAiInfo, icon: const Icon(IconlyLight.info_square)),
                          IconButton(
                            onPressed: onToggleCompare,
                            icon: Icon(isInComparison ? IconlyBold.shield_done : IconlyLight.shield_done),
                          ),
                          const Spacer(),
                          ElevatedButton(
                            onPressed: onTap,
                            child: const Text('View'),
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ).animate().slide(begin: const Offset(0, 0.1)).fadeIn(duration: 400.ms),
      ),
    );
  }
}
