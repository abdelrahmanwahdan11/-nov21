import 'package:flutter/material.dart';

import '../../controllers/search_controller.dart';
import '../../core/localization/app_localizations.dart';

class FiltersBottomSheet extends StatefulWidget {
  const FiltersBottomSheet({super.key, required this.controller});

  final SearchController controller;

  @override
  State<FiltersBottomSheet> createState() => _FiltersBottomSheetState();
}

class _FiltersBottomSheetState extends State<FiltersBottomSheet> {
  late double _price = widget.controller.filters.maxPrice;
  late double _rating = widget.controller.filters.minRating;
  late double _distance = widget.controller.filters.maxDistance;
  late List<String> _types = List.of(widget.controller.filters.types);

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 8),
            Container(height: 4, width: 60, decoration: BoxDecoration(color: Colors.grey.shade400, borderRadius: BorderRadius.circular(12))),
            const SizedBox(height: 16),
            Text(t.translate('filters_title'), style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 24),
            _buildSlider(t.translate('max_price'), _price, 100, 600, (value) => setState(() => _price = value)),
            _buildSlider(t.translate('min_rating'), _rating, 1, 5, (value) => setState(() => _rating = value)),
            _buildSlider(t.translate('max_distance'), _distance, 1, 25, (value) => setState(() => _distance = value)),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(t.translate('hotel_type'), style: Theme.of(context).textTheme.titleMedium),
            ),
            ...['luxury', 'business', 'urban', 'beach', 'family', 'budget', 'boutique'].map(
              (type) => CheckboxListTile(
                value: _types.contains(type),
                onChanged: (value) {
                  setState(() {
                    if (value == true) {
                      _types.add(type);
                    } else {
                      _types.remove(type);
                    }
                  });
                },
                title: Text(type[0].toUpperCase() + type.substring(1)),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      widget.controller.resetFilters();
                      Navigator.of(context).pop();
                    },
                    child: Text(t.translate('reset')),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      widget.controller.updateFilters(
                        widget.controller.filters.copyWith(
                          maxPrice: _price,
                          minRating: _rating,
                          maxDistance: _distance,
                          types: _types,
                        ),
                      );
                      Navigator.of(context).pop();
                    },
                    child: Text(t.translate('apply')),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildSlider(String title, double value, double min, double max, ValueChanged<double> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('$title: ${value.toStringAsFixed(1)}'),
        Slider(value: value, min: min, max: max, onChanged: onChanged),
      ],
    );
  }
}
