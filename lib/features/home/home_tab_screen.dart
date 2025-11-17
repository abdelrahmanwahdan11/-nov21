import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:iconly/iconly.dart';

import '../../controllers/comparison_controller.dart';
import '../../controllers/hotels_controller.dart';
import '../../core/localization/app_localizations.dart';
import '../../core/widgets/section_header.dart';
import '../../core/widgets/skeleton_loader.dart';
import '../../models/hotel.dart';
import '../comparison/comparison_screen.dart';
import '../hotel_detail/hotel_detail_screen.dart';
import 'hotel_card_widget.dart';
import 'featured_3d_carousel_widget.dart';

class HomeTabScreen extends StatefulWidget {
  const HomeTabScreen({super.key, required this.hotelsController, required this.comparisonController});

  final HotelsController hotelsController;
  final ComparisonController comparisonController;

  @override
  State<HomeTabScreen> createState() => _HomeTabScreenState();
}

class _HomeTabScreenState extends State<HomeTabScreen> {
  final categories = const ['Premium', 'Essential', 'Luxury', 'Suites'];

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: widget.hotelsController.refresh,
      child: AnimatedBuilder(
        animation: Listenable.merge([widget.hotelsController, widget.hotelsController.hotelsNotifier]),
        builder: (context, _) {
          final hotels = widget.hotelsController.hotelsNotifier.value;
          if (widget.hotelsController.isLoading) {
            return RefreshIndicator(
              onRefresh: widget.hotelsController.refresh,
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: 4,
                itemBuilder: (_, __) => const SkeletonLoader(height: 140),
              ),
            );
          }
          return ListView(
            padding: const EdgeInsets.only(bottom: 120),
            physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            children: [
              _buildHeader(context),
              Featured3DCarousel(hotels: hotels.take(5).toList()),
              const SizedBox(height: 12),
              _buildCategoryChips(context),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: SizedBox(
                  height: 140,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    children: [
                      _OfferCard(title: 'Stay 3, get spa credits'),
                      _OfferCard(title: 'Members save 15% midweek'),
                    ],
                  ),
                ),
              ),
              SectionHeader(
                title: AppLocalizations.of(context).translate('home'),
                actionLabel: AppLocalizations.of(context).translate('compare'),
                onAction: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => ComparisonScreen(controller: widget.comparisonController),
                    ),
                  );
                },
              ),
              ...hotels.map((hotel) => HotelCardWidget(
                    hotel: hotel,
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => HotelDetailScreen(hotel: hotel)),
                    ),
                    onAiInfo: () => _showAiInfo(context),
                    onToggleCompare: () => widget.comparisonController.toggleHotel(hotel),
                    isInComparison: widget.comparisonController.contains(hotel),
                  )).toList(),
              if (widget.hotelsController.isLoadingMore)
                const Padding(
                  padding: EdgeInsets.all(16),
                  child: CircularProgressIndicator(),
                )
              else
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: OutlinedButton(
                    onPressed: widget.hotelsController.loadMore,
                    child: const Text('Load more'),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return ListTile(
      leading: const CircleAvatar(
        backgroundImage: NetworkImage('https://images.unsplash.com/photo-1500648767791-00dcc994a43e'),
        radius: 28,
      ),
      title: Text(
        'Dubai',
        style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
      ),
      subtitle: const Text('Curated by Roamify AI'),
      trailing: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Image.network(
          'https://images.unsplash.com/photo-1528909514045-2fa4ac7a08ba',
          width: 90,
          height: 70,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildCategoryChips(BuildContext context) {
    return SizedBox(
      height: 56,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final category = categories[index];
          final active = widget.hotelsController.category == category;
          return ChoiceChip(
            label: Text(category),
            selected: active,
            onSelected: (_) => setState(() => widget.hotelsController.updateCategory(category)),
            selectedColor: Theme.of(context).colorScheme.primary.withOpacity(.2),
          );
        },
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemCount: categories.length,
      ),
    );
  }

  void _showAiInfo(BuildContext context) {
    final t = AppLocalizations.of(context);
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(32))),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(IconlyBold.info_square, size: 48),
            const SizedBox(height: 16),
            Text(t.translate('ai_info')),
          ],
        ),
      ),
    );
  }
}

class _OfferCard extends StatelessWidget {
  const _OfferCard({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary.withOpacity(.2),
        borderRadius: BorderRadius.circular(28),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Roamify Rewards', style: Theme.of(context).textTheme.labelSmall),
          const Spacer(),
          Text(title, style: Theme.of(context).textTheme.titleMedium),
        ],
      ),
    );
  }
}
