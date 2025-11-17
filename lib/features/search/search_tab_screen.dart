import 'package:flutter/material.dart';
import '../../controllers/comparison_controller.dart';
import '../../controllers/hotels_controller.dart';
import '../../controllers/search_controller.dart';
import '../../core/localization/app_localizations.dart';
import '../../core/widgets/section_header.dart';
import 'filters_bottom_sheet.dart';
import '../hotel_detail/hotel_detail_screen.dart';

class SearchTabScreen extends StatelessWidget {
  const SearchTabScreen({super.key, required this.hotelsController, required this.searchController, required this.comparisonController});

  final HotelsController hotelsController;
  final SearchController searchController;
  final ComparisonController comparisonController;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final filters = ['luxury', 'business', 'urban', 'beach', 'family', 'budget', 'boutique'];
    return AnimatedBuilder(
      animation: searchController,
      builder: (context, _) {
        final hotels = searchController.results;
        return RefreshIndicator(
          onRefresh: hotelsController.refresh,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              TextField(
                decoration: InputDecoration(prefixIcon: const Icon(Icons.search), hintText: t.translate('search_hint')),
                onChanged: searchController.updateQuery,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  ElevatedButton.icon(
                    icon: const Icon(Icons.filter_list),
                    onPressed: () => showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (_) => FiltersBottomSheet(controller: searchController),
                    ),
                    label: Text(t.translate('filters')),
                  ),
                  const SizedBox(width: 8),
                  _SortButton(controller: searchController, label: t.translate('sort')),
                  const Spacer(),
                  Text(t.translate('results')),
                  const SizedBox(width: 4),
                  CircleAvatar(backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.1), child: Text('${hotels.length}')),
                ],
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                children: filters
                    .map((tag) => FilterChip(
                          selected: searchController.filters.types.contains(tag),
                          label: Text(tag[0].toUpperCase() + tag.substring(1)),
                          onSelected: (selected) {
                            final current = List<String>.from(searchController.filters.types);
                            if (selected) {
                              current.add(tag);
                            } else {
                              current.remove(tag);
                            }
                            searchController.updateFilters(searchController.filters.copyWith(types: current));
                          },
                        ))
                    .toList(),
              ),
              const SizedBox(height: 12),
              SectionHeader(title: '${t.translate('results')} (${hotels.length})', action: null),
              ...hotels.map((h) => ListTile(
                    leading: ClipRRect(borderRadius: BorderRadius.circular(12), child: Image.network(h.image, width: 60, height: 60, fit: BoxFit.cover)),
                    title: Text(h.name),
                    subtitle: Text('${h.city} • ${h.tags.join(', ')}'),
                    trailing: IconButton(icon: const Icon(Icons.compare_arrows), onPressed: () => comparisonController.toggle(h)),
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => HotelDetailScreen(hotel: h))),
                  )),
              const SizedBox(height: 8),
              TextButton(onPressed: hotelsController.loadMore, child: Text(t.translate('load_more'))),
            ],
          ),
        );
      },
    );
  }
}

class _SortButton extends StatelessWidget {
  const _SortButton({required this.controller, this.label});
  final SearchController controller;
  final String? label;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<SortOption>(
      onSelected: controller.updateSort,
      itemBuilder: (_) => const [
        PopupMenuItem(value: SortOption.price, child: Text('Price')),
        PopupMenuItem(value: SortOption.rating, child: Text('Rating')),
        PopupMenuItem(value: SortOption.distance, child: Text('Distance')),
      ],
      child: Text(label ?? 'Sort'),
    );
  }
}
