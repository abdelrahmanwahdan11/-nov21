import 'package:flutter/material.dart';

import '../../controllers/comparison_controller.dart';
import '../../controllers/hotels_controller.dart';
import '../../controllers/search_controller.dart';
import '../../core/localization/app_localizations.dart';
import '../../core/widgets/section_header.dart';
import '../../core/widgets/skeleton_loader.dart';
import '../comparison/comparison_screen.dart';
import '../home/hotel_card_widget.dart';
import '../hotel_detail/hotel_detail_screen.dart';
import 'catalog_screen.dart';
import 'filters_bottom_sheet.dart';

class SearchTabScreen extends StatelessWidget {
  const SearchTabScreen({
    super.key,
    required this.hotelsController,
    required this.searchController,
    required this.comparisonController,
  });

  final HotelsController hotelsController;
  final SearchController searchController;
  final ComparisonController comparisonController;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return AnimatedBuilder(
      animation: Listenable.merge([hotelsController, hotelsController.hotelsNotifier, searchController]),
      builder: (context, _) {
        final hotels = hotelsController.hotelsNotifier.value;
        if (hotelsController.isLoading) {
          return RefreshIndicator(
            onRefresh: hotelsController.refresh,
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: 4,
              itemBuilder: (_, __) => const SkeletonLoader(height: 140),
            ),
          );
        }
        return RefreshIndicator(
          onRefresh: hotelsController.refresh,
          child: ListView(
            padding: const EdgeInsets.only(bottom: 120),
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    TextField(
                      controller: searchController.queryController,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.search),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            searchController.queryController.clear();
                            searchController.updateQuery('');
                          },
                        ),
                        hintText: t.translate('search'),
                      ),
                      onChanged: searchController.updateQuery,
                    ),
                    const SizedBox(height: 16),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(28),
                      child: Image.network(
                        'https://images.unsplash.com/photo-1500534314209-a25ddb2bd429',
                        height: 140,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    ElevatedButton.icon(
                      onPressed: () => _openFilters(context),
                      icon: const Icon(Icons.tune),
                      label: Text(t.translate('filters')),
                    ),
                    const SizedBox(width: 12),
                    OutlinedButton.icon(
                      onPressed: () => _openSort(context),
                      icon: const Icon(Icons.sort),
                      label: Text(t.translate('sort')),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => ComparisonScreen(controller: comparisonController),
                        ),
                      ),
                      icon: const Icon(Icons.view_week_rounded),
                    ),
                  ],
                ),
              ),
              SectionHeader(title: t.translate('catalog')),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton.icon(
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => CatalogScreen(
                          hotelsController: hotelsController,
                          searchController: searchController,
                        ),
                      ),
                    ),
                    icon: const Icon(Icons.dashboard_customize_outlined),
                    label: Text(t.translate('open_catalog')),
                  ),
                ),
              ),
              SizedBox(
                height: 44,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: ['Family', 'Business', 'Beach', 'Wellness', 'Romantic']
                      .map((c) => Padding(
                            padding: const EdgeInsets.only(right: 12),
                            child: FilterChip(
                              label: Text(c),
                              selected: searchController.filters.tags.contains(c.toLowerCase()),
                              onSelected: (value) {
                                final tags = List<String>.from(searchController.filters.tags);
                                if (value) {
                                  if (!tags.contains(c.toLowerCase())) {
                                    tags.add(c.toLowerCase());
                                  }
                                } else {
                                  tags.remove(c.toLowerCase());
                                }
                                searchController.updateFilters(
                                  searchController.filters.copyWith(tags: tags),
                                );
                              },
                            ),
                          ))
                      .toList(),
                ),
              ),
              ...hotels.map((hotel) => HotelCardWidget(
                    hotel: hotel,
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (_) => HotelDetailScreen(hotel: hotel)));
                    },
                    onAiInfo: () => _showAiInfo(context),
                    onToggleCompare: () => comparisonController.toggleHotel(hotel),
                    isInComparison: comparisonController.contains(hotel),
                    onToggleFavorite: () => hotelsController.toggleFavorite(hotel),
                    isFavorite: hotelsController.isFavorite(hotel),
                  )),
              if (hotelsController.isLoadingMore)
                const Center(child: Padding(padding: EdgeInsets.all(16), child: CircularProgressIndicator()))
              else
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: OutlinedButton(
                    onPressed: () => hotelsController.loadMore(
                      query: searchController.queryController.text,
                      ignoreCategory: true,
                    ),
                    child: Text(t.translate('load_more')),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  void _openFilters(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(32))),
      builder: (context) => FiltersBottomSheet(controller: searchController),
    );
  }

  void _openSort(BuildContext context) {
    final t = AppLocalizations.of(context);
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(32))),
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: Text(t.translate('sort_price')),
            onTap: () {
              hotelsController.setSort(HotelSort.price);
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text(t.translate('sort_rating')),
            onTap: () {
              hotelsController.setSort(HotelSort.rating);
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text(t.translate('sort_distance')),
            onTap: () {
              hotelsController.setSort(HotelSort.distance);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  void _showAiInfo(BuildContext context) {
    final t = AppLocalizations.of(context);
    showModalBottomSheet(
      context: context,
      builder: (context) => Padding(
        padding: const EdgeInsets.all(24),
        child: Text(t.translate('ai_info')),
      ),
    );
  }
}
