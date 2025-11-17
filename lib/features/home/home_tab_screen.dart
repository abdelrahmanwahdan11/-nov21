import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:iconly/iconly.dart';
import '../../controllers/bookings_controller.dart';
import '../../controllers/comparison_controller.dart';
import '../../controllers/hotels_controller.dart';
import '../../core/localization/app_localizations.dart';
import '../../core/widgets/primary_button.dart';
import '../../core/widgets/section_header.dart';
import '../../core/widgets/skeleton_loader.dart';
import '../../models/booking.dart';
import '../../models/hotel.dart';
import '../rewards_profile/my_trips_screen.dart';
import 'favorites_screen.dart';
import '../hotel_detail/hotel_detail_screen.dart';

class HomeTabScreen extends StatelessWidget {
  const HomeTabScreen({super.key, required this.hotelsController, required this.comparisonController, required this.bookingsController});

  final HotelsController hotelsController;
  final ComparisonController comparisonController;
  final BookingsController bookingsController;

  @override
  Widget build(BuildContext context) {
    final t = Localizations.of<AppLocalizations>(context, AppLocalizations)!;
    return AnimatedBuilder(
      animation: hotelsController,
      builder: (context, _) {
        final hotels = hotelsController.visible;
        return RefreshIndicator(
          onRefresh: hotelsController.refresh,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              SectionHeader(title: t.translate('welcome'), action: const Icon(IconlyLight.location)),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => FavoritesScreen(
                            hotelsController: hotelsController,
                            bookingsController: bookingsController,
                          ),
                        ),
                      ),
                      icon: const Icon(IconlyLight.heart),
                      label: Text(t.translate('open_favorites')),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => MyTripsScreen(bookingsController: bookingsController),
                        ),
                      ),
                      icon: const Icon(IconlyLight.calendar),
                      label: Text(t.translate('open_bookings')),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              _FeaturedCarousel(items: hotels),
              const SizedBox(height: 24),
              SectionHeader(
                title: t.translate('popular_stays'),
                action: TextButton(
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => FavoritesScreen(
                        hotelsController: hotelsController,
                        bookingsController: bookingsController,
                      ),
                    ),
                  ),
                  child: Text(t.translate('view_all')),
                ),
              ),
              const SizedBox(height: 12),
              ...hotels.map(
                (h) => _HotelCard(
                  hotel: h,
                  onFavorite: () => hotelsController.toggleFavorite(h.id),
                  onCompare: () => comparisonController.toggle(h),
                  onBook: () {
                    bookingsController.addBooking(
                      Booking(
                        id: DateTime.now().toIso8601String(),
                        hotel: h,
                        date: DateTime.now().add(const Duration(days: 2)),
                        nights: 2,
                        guests: 2,
                      ),
                    );
                  },
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => HotelDetailScreen(hotel: h)),
                  ),
                ),
              ),
              if (hotelsController.isLoadingMore)
                ...List.generate(
                  2,
                  (_) => const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: SkeletonLoader(height: 120),
                  ),
                ),
              TextButton(onPressed: hotelsController.loadMore, child: Text(t.translate('load_more'))),
            ],
          ),
        );
      },
    );
  }
}

class _FeaturedCarousel extends StatelessWidget {
  const _FeaturedCarousel({required this.items});
  final List<Hotel> items;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      child: PageView.builder(
        controller: PageController(viewportFraction: 0.8),
        itemCount: items.length,
        itemBuilder: (_, i) {
          final hotel = items[i];
          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            margin: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              image: DecorationImage(image: NetworkImage(hotel.image), fit: BoxFit.cover),
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                gradient: LinearGradient(colors: [Colors.black.withOpacity(0.2), Colors.black.withOpacity(0.6)], begin: Alignment.topCenter, end: Alignment.bottomCenter),
              ),
              padding: const EdgeInsets.all(16),
              alignment: Alignment.bottomLeft,
              child: Text(hotel.name, style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white)),
            ),
          ).animate().slide();
        },
      ),
    );
  }
}

class _HotelCard extends StatelessWidget {
  const _HotelCard({required this.hotel, required this.onFavorite, required this.onCompare, required this.onBook, required this.onTap});

  final Hotel hotel;
  final VoidCallback onFavorite;
  final VoidCallback onCompare;
  final VoidCallback onBook;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final t = Localizations.of<AppLocalizations>(context, AppLocalizations)!;
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(hotel.image, height: 90, width: 90, fit: BoxFit.cover),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(hotel.name, style: Theme.of(context).textTheme.titleMedium),
                        const SizedBox(height: 4),
                        Text('${hotel.city} • ${hotel.distanceKm.toStringAsFixed(1)} km'),
                        Text('\$${hotel.price.toStringAsFixed(0)} / night'),
                      ],
                    ),
                  ),
                  IconButton(onPressed: onFavorite, icon: const Icon(IconlyLight.heart)),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  PrimaryButton(text: t.translate('book_now'), onPressed: onBook),
                  const SizedBox(width: 12),
                  OutlinedButton(onPressed: onCompare, child: Text(t.translate('compare'))),
                  const Spacer(),
                  IconButton(
                    onPressed: () => showModalBottomSheet(
                      context: context,
                      builder: (_) => Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Text(t.translate('ai_info')),
                      ),
                    ),
                    icon: const Icon(IconlyLight.info_circle),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
