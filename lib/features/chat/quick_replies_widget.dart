import 'package:flutter/material.dart';

class QuickRepliesWidget extends StatelessWidget {
  const QuickRepliesWidget({super.key, required this.onTap});

  final ValueChanged<String> onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: ['Stay cost', 'AI picks', 'Hotel match']
            .map((text) => Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: ActionChip(
                    label: Text(text),
                    onPressed: () => onTap(text),
                  ),
                ))
            .toList(),
      ),
    );
  }
}
