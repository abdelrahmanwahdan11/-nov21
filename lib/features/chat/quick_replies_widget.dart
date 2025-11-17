import 'package:flutter/material.dart';

class QuickRepliesWidget extends StatelessWidget {
  const QuickRepliesWidget({super.key, required this.onSelect});

  final ValueChanged<String> onSelect;

  @override
  Widget build(BuildContext context) {
    final replies = ['Stay cost', 'AI picks', 'Hotel match'];
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: replies
            .map((text) => Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: ChoiceChip(
                    label: Text(text),
                    selected: false,
                    onSelected: (_) => onSelect(text),
                  ),
                ))
            .toList(),
      ),
    );
  }
}
