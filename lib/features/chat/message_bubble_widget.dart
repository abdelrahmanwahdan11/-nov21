import 'package:flutter/material.dart';

import '../../core/utils/dummy_data.dart';
import '../../models/chat_message.dart';

class MessageBubbleWidget extends StatelessWidget {
  const MessageBubbleWidget({super.key, required this.message});

  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    final isUser = message.sender == SenderType.user;
    final align = isUser ? Alignment.centerRight : Alignment.centerLeft;
    final color = isUser
        ? Theme.of(context).colorScheme.primary
        : Theme.of(context).colorScheme.primary.withOpacity(.08);
    final textColor = isUser ? Colors.white : Theme.of(context).textTheme.bodyLarge?.color;
    return Align(
      alignment: align,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              message.text,
              style: TextStyle(color: textColor),
            ),
            if (!isUser)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: SizedBox(
                  height: 60,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: ['Suites', 'Skyline', 'Wellness']
                        .map((c) => Container(
                              margin: const EdgeInsets.only(right: 8),
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                              decoration: BoxDecoration(
                                color: lighten(Theme.of(context).colorScheme.primary),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Text(c),
                            ))
                        .toList(),
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
