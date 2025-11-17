import 'package:flutter/material.dart';

import '../../controllers/hotels_controller.dart';
import '../../controllers/search_controller.dart';
import '../../core/localization/app_localizations.dart';

class CatalogScreen extends StatelessWidget {
  const CatalogScreen({
    super.key,
    required this.hotelsController,
    required this.searchController,
  });

  final HotelsController hotelsController;
  final SearchController searchController;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final hotels = hotelsController.allHotels;
    final Map<String, int> categories = {};
    for (final hotel in hotels) {
      categories.update(hotel.type, (value) => value + 1, ifAbsent: () => 1);
    }
    final Set<String> tags = hotels.expand((h) => h.tags).map((e) => e.toLowerCase()).toSet();
    return Scaffold(
      appBar: AppBar(title: Text(t.translate('catalog'))),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          Text(t.translate('catalog_intro'), style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 16),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: categories.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 1.1,
            ),
            itemBuilder: (context, index) {
              final entry = categories.entries.elementAt(index);
              final type = entry.key;
              final count = entry.value;
              return _CategoryCard(
                title: type,
                count: count,
                counterLabel: t.translate('stays'),
                onTap: () {
                  final currentTags = searchController.filters.tags;
                  searchController.updateFilters(
                    searchController.filters.copyWith(types: [type], tags: currentTags),
                  );
                  Navigator.pop(context);
                },
              );
            },
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(child: Text(t.translate('tags'), style: Theme.of(context).textTheme.titleMedium)),
              TextButton(
                onPressed: () {
                  searchController.resetFilters();
                  Navigator.pop(context);
                },
                child: Text(t.translate('reset')),
              )
            ],
          ),
          Wrap(
            spacing: 10,
            runSpacing: 8,
            children: tags
                .map(
                  (tag) => FilterChip(
                    label: Text(tag),
                    selected: searchController.filters.tags.contains(tag),
                    onSelected: (value) {
                      final updatedTags = List<String>.from(searchController.filters.tags);
                      if (value) {
                        updatedTags.add(tag);
                      } else {
                        updatedTags.remove(tag);
                      }
                      searchController.updateFilters(
                        searchController.filters.copyWith(tags: updatedTags),
                      );
                    },
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}

class _CategoryCard extends StatelessWidget {
  const _CategoryCard({
    required this.title,
    required this.count,
    required this.counterLabel,
    required this.onTap,
  });

  final String title;
  final int count;
  final String counterLabel;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).cardColor,
      borderRadius: BorderRadius.circular(24),
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
              Row(
                children: [
                  const Icon(Icons.king_bed_outlined),
                  const SizedBox(width: 8),
                  Text('$count $counterLabel'),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
