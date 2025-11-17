import 'package:flutter/material.dart';

import '../../core/localization/app_localizations.dart';
import '../../models/hotel.dart';
import 'hotel_detail_flip_card_widget.dart';
import 'hotel_image_overlay_widget.dart';

class HotelDetailScreen extends StatefulWidget {
  const HotelDetailScreen({super.key, required this.hotel});

  final Hotel hotel;

  @override
  State<HotelDetailScreen> createState() => _HotelDetailScreenState();
}

class _HotelDetailScreenState extends State<HotelDetailScreen> {
  bool _overlayVisible = false;

  @override
  Widget build(BuildContext context) {
    final hotel = widget.hotel;
    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 320,
                flexibleSpace: FlexibleSpaceBar(
                  background: Hero(
                    tag: hotel.id,
                    child: GestureDetector(
                      onTap: () => setState(() => _overlayVisible = true),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.network(hotel.image, fit: BoxFit.cover),
                          Container(
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [Colors.black54, Colors.transparent],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
                  ),
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(hotel.name, style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      Text('${hotel.city} · ${hotel.distance} km · ⭐️${hotel.rating} (${hotel.reviews} reviews)'),
                      const SizedBox(height: 16),
                      Wrap(
                        spacing: 8,
                        children: hotel.amenities.map((a) => Chip(label: Text(a))).toList(),
                      ),
                      const SizedBox(height: 24),
                      Text(hotel.description),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: () {},
                        child: Text('${AppLocalizations.of(context).translate('book_now')} · ${hotel.price.toStringAsFixed(0)} AED'),
                      ),
                      const SizedBox(height: 24),
                      const Text('Flip insights'),
                      const SizedBox(height: 12),
                      HotelDetailFlipCardWidget(hotel: hotel),
                      const SizedBox(height: 24),
                      OutlinedButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Gallery'),
                              content: SizedBox(
                                height: 220,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) => Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(24),
                                      child: Image.network(hotel.image, width: 200, fit: BoxFit.cover),
                                    ),
                                  ),
                                  itemCount: 3,
                                ),
                              ),
                            ),
                          );
                        },
                        child: const Text('Videos & more photos'),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
          if (_overlayVisible)
            HotelImageOverlayWidget(
              hotel: hotel,
              onClose: () => setState(() => _overlayVisible = false),
            )
        ],
      ),
    );
  }
}
