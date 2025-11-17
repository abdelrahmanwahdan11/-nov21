import 'package:flutter/material.dart';
import '../../controllers/comparison_controller.dart';
import '../../controllers/hotels_controller.dart';
import '../../controllers/search_controller.dart';
import '../../core/widgets/section_header.dart';
import '../hotel_detail/hotel_detail_screen.dart';

class SearchTabScreen extends StatelessWidget {
  const SearchTabScreen({super.key, required this.hotelsController, required this.searchController, required this.comparisonController});

  final HotelsController hotelsController;
  final SearchController searchController;
  final ComparisonController comparisonController;

  @override
  Widget build(BuildContext context) {
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
                decoration: const InputDecoration(prefixIcon: Icon(Icons.search), hintText: 'Search hotels'),
                onChanged: searchController.updateQuery,
              ),
              const SizedBox(height: 16),
              SectionHeader(title: 'Results (${hotels.length})', action: _SortButton(controller: searchController)),
              ...hotels.map((h) => ListTile(
                    leading: ClipRRect(borderRadius: BorderRadius.circular(12), child: Image.network(h.image, width: 60, height: 60, fit: BoxFit.cover)),
                    title: Text(h.name),
                    subtitle: Text('${h.city} • ${h.tags.join(', ')}'),
                    trailing: IconButton(icon: const Icon(Icons.compare_arrows), onPressed: () => comparisonController.toggle(h)),
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => HotelDetailScreen(hotel: h))),
                  )),
              TextButton(onPressed: hotelsController.loadMore, child: const Text('Load more')),
            ],
          ),
        );
      },
    );
  }
}

class _SortButton extends StatelessWidget {
  const _SortButton({required this.controller});
  final SearchController controller;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<SortOption>(
      onSelected: controller.updateSort,
      itemBuilder: (_) => const [
        PopupMenuItem(value: SortOption.price, child: Text('Price')),
        PopupMenuItem(value: SortOption.rating, child: Text('Rating')),
        PopupMenuItem(value: SortOption.distance, child: Text('Distance')),
      ],
      child: const Text('Sort'),
    );
  }
}
