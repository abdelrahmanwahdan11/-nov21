import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

import '../../controllers/comparison_controller.dart';
import '../../controllers/hotels_controller.dart';
import '../../controllers/search_controller.dart';
import '../../core/localization/app_localizations.dart';
import '../../core/widgets/section_header.dart';
import '../hotel_detail/hotel_detail_screen.dart';
import 'filters_bottom_sheet.dart';

class SearchTabScreen extends StatefulWidget {
  const SearchTabScreen({super.key, required this.hotelsController, required this.searchController, required this.comparisonController});

  final HotelsController hotelsController;
  final SearchController searchController;
  final ComparisonController comparisonController;

  @override
  State<SearchTabScreen> createState() => _SearchTabScreenState();
}

class _SearchTabScreenState extends State<SearchTabScreen> {
  late final TextEditingController _queryController;

  @override
  void initState() {
    super.initState();
    _queryController = TextEditingController(text: widget.searchController.query);
  }

  @override
  void dispose() {
    _queryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final filters = ['luxury', 'business', 'urban', 'beach', 'family', 'budget', 'boutique'];
    return AnimatedBuilder(
      animation: widget.searchController,
      builder: (context, _) {
        final hotels = widget.searchController.results;
        return RefreshIndicator(
          onRefresh: widget.hotelsController.refresh,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              TextField(
                controller: _queryController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  hintText: t.translate('search_hint'),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.history_toggle_off),
                    onPressed: () => widget.searchController.addRecentQuery(_queryController.text),
                  ),
                ),
                textInputAction: TextInputAction.search,
                onChanged: widget.searchController.updateQuery,
                onSubmitted: (value) {
                  widget.searchController.updateQuery(value);
                  widget.searchController.addRecentQuery(value);
                },
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  ElevatedButton.icon(
                    icon: const Icon(Icons.filter_list),
                    onPressed: () => showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (_) => FiltersBottomSheet(controller: widget.searchController),
                    ),
                    label: Text(t.translate('filters')),
                  ),
                  const SizedBox(width: 8),
                  _SortButton(controller: widget.searchController, label: t.translate('sort')),
                  const SizedBox(width: 8),
                  TextButton.icon(
                    onPressed: () => _openPresetSheet(context),
                    icon: const Icon(Icons.bookmark_add_outlined),
                    label: Text(t.translate('save_preset')),
                  ),
                  const Spacer(),
                  Text(t.translate('results')),
                  const SizedBox(width: 4),
                  CircleAvatar(backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.1), child: Text('${hotels.length}')),
                ],
              ),
              const SizedBox(height: 12),
              if (widget.searchController.recentQueries.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SectionHeader(
                      title: t.translate('recent_searches'),
                      action: TextButton(
                        onPressed: widget.searchController.clearRecents,
                        child: Text(t.translate('clear_all')),
                      ),
                    ),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: widget.searchController.recentQueries
                          .map(
                            (q) => ActionChip(
                              avatar: const Icon(IconlyLight.search, size: 16),
                              label: Text(q),
                              onPressed: () {
                                _queryController.text = q;
                                widget.searchController.updateQuery(q);
                              },
                            ),
                          )
                          .toList(),
                    ),
                    const SizedBox(height: 12),
                  ],
                ),
              Wrap(
                spacing: 8,
                children: filters
                    .map((tag) => FilterChip(
                          selected: widget.searchController.filters.types.contains(tag),
                          label: Text(tag[0].toUpperCase() + tag.substring(1)),
                          onSelected: (selected) {
                            final current = List<String>.from(widget.searchController.filters.types);
                            if (selected) {
                              current.add(tag);
                            } else {
                              current.remove(tag);
                            }
                            widget.searchController.updateFilters(widget.searchController.filters.copyWith(types: current));
                          },
                        ))
                    .toList(),
              ),
              const SizedBox(height: 12),
              if (widget.searchController.presets.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SectionHeader(title: t.translate('saved_presets'), action: null),
                    ...widget.searchController.presets.map(
                      (preset) => Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(preset.label, style: Theme.of(context).textTheme.titleMedium),
                                    const SizedBox(height: 6),
                                    Text(
                                      '${preset.query.isEmpty ? t.translate('filters') : preset.query} · ${preset.filters.minRating}+ ★ · ≤ ${preset.filters.maxPrice.toStringAsFixed(0)}',
                                    ),
                                  ],
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete_outline),
                                onPressed: () => widget.searchController.removePreset(preset.label),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  widget.searchController.applyPreset(preset);
                                  _queryController.text = preset.query;
                                },
                                child: Text(t.translate('apply')),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              SectionHeader(title: '${t.translate('results')} (${hotels.length})', action: null),
              ...hotels.map((h) => ListTile(
                    leading: ClipRRect(borderRadius: BorderRadius.circular(12), child: Image.network(h.image, width: 60, height: 60, fit: BoxFit.cover)),
                    title: Text(h.name),
                    subtitle: Text('${h.city} • ${h.tags.join(', ')}'),
                    trailing: IconButton(icon: const Icon(Icons.compare_arrows), onPressed: () => widget.comparisonController.toggle(h)),
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => HotelDetailScreen(hotel: h))),
                  )),
              const SizedBox(height: 8),
              TextButton(onPressed: widget.hotelsController.loadMore, child: Text(t.translate('load_more'))),
            ],
          ),
        );
      },
    );
  }

  void _openPresetSheet(BuildContext context) {
    final controller = TextEditingController();
    final t = AppLocalizations.of(context);
    showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(t.translate('save_preset'), style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: t.translate('preset_hint'),
                filled: true,
                fillColor: Theme.of(context).cardColor,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
              ),
            ),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () {
                  widget.searchController.savePreset(controller.text);
                  Navigator.pop(context);
                },
                child: Text(t.translate('save')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SortButton extends StatelessWidget {
  const _SortButton({required this.controller, this.label});
  final SearchController controller;
  final String? label;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return PopupMenuButton<SortOption>(
      onSelected: controller.updateSort,
      itemBuilder: (_) => [
        PopupMenuItem(value: SortOption.price, child: Text(t.translate('sort_price'))),
        PopupMenuItem(value: SortOption.rating, child: Text(t.translate('sort_rating'))),
        PopupMenuItem(value: SortOption.distance, child: Text(t.translate('sort_distance'))),
      ],
      child: Text(label ?? t.translate('sort')),
    );
  }
}
