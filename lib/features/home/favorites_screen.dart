import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

import '../../controllers/bookings_controller.dart';
import '../../controllers/hotels_controller.dart';
import '../../core/localization/app_localizations.dart';
import '../hotel_detail/hotel_detail_screen.dart';
import 'hotel_card_widget.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key, required this.hotelsController, required this.bookingsController});

  final HotelsController hotelsController;
  final BookingsController bookingsController;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return AnimatedBuilder(
      animation: hotelsController,
      builder: (context, _) {
        final favorites = hotelsController.allHotels.where((h) => hotelsController.isFavorite(h)).toList();
        return Scaffold(
          appBar: AppBar(title: Text(t.translate('favorites'))),
          body: favorites.isEmpty
              ? Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(IconlyLight.heart, size: 64),
                      const SizedBox(height: 12),
                      Text(t.translate('no_favorites')),
                      const SizedBox(height: 8),
                      Text(t.translate('add_more_hotels')),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.only(bottom: 32),
                  itemCount: favorites.length,
                  itemBuilder: (context, index) {
                    final hotel = favorites[index];
                    return HotelCardWidget(
                      hotel: hotel,
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => HotelDetailScreen(hotel: hotel, bookingsController: bookingsController),
                        ),
                      ),
                      onAiInfo: () => _showInfo(context),
                      onToggleCompare: () {},
                      isInComparison: false,
                      onToggleFavorite: () => hotelsController.toggleFavorite(hotel),
                      isFavorite: true,
                    );
                  },
                ),
        );
      },
    );
  }

  void _showInfo(BuildContext context) {
    final t = AppLocalizations.of(context);
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(32))),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(t.translate('ai_info_title'), style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Text(t.translate('ai_info_desc')),
          ],
        ),
      ),
    );
  }
}
