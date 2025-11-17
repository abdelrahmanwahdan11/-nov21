import 'package:flutter/material.dart';
import '../../models/hotel.dart';
import 'hotel_image_overlay_widget.dart';

class HotelDetailScreen extends StatelessWidget {
  const HotelDetailScreen({super.key, required this.hotel});

  final Hotel hotel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Hero(
            tag: hotel.id,
            child: GestureDetector(
              onTap: () => Navigator.push(context, PageRouteBuilder(opaque: false, pageBuilder: (_, __, ___) => HotelImageOverlayWidget(hotel: hotel))),
              child: Image.network(hotel.image, height: 320, width: double.infinity, fit: BoxFit.cover),
            ),
          ),
          Positioned.fill(
            top: 280,
            child: DraggableScrollableSheet(
              initialChildSize: 0.65,
              builder: (_, controller) => Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                ),
                padding: const EdgeInsets.all(24),
                child: ListView(
                  controller: controller,
                  children: [
                    Text(hotel.name, style: Theme.of(context).textTheme.headlineSmall),
                    const SizedBox(height: 8),
                    Text(hotel.description),
                    const SizedBox(height: 16),
                    Wrap(spacing: 8, children: hotel.amenities.map((e) => Chip(label: Text(e))).toList()),
                    const SizedBox(height: 24),
                    ElevatedButton(onPressed: () => Navigator.pop(context), child: const Text('Close')),
                  ],
                ),
              ),
            ),
          ),
          SafeArea(child: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => Navigator.pop(context))),
        ],
      ),
    );
  }
}
