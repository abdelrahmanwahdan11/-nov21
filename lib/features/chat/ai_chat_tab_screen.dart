import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../controllers/chat_controller.dart';
import '../../core/localization/app_localizations.dart';
import 'message_bubble_widget.dart';
import 'quick_replies_widget.dart';

class AiChatTabScreen extends StatefulWidget {
  const AiChatTabScreen({super.key, required this.controller});

  final ChatController controller;

  @override
  State<AiChatTabScreen> createState() => _AiChatTabScreenState();
}

class _AiChatTabScreenState extends State<AiChatTabScreen> {
  final _inputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Column(
      children: [
        Expanded(
          child: AnimatedBuilder(
            animation: widget.controller,
            builder: (context, _) {
              final messages = widget.controller.messages;
              return ListView.builder(
                controller: widget.controller.scrollController,
                padding: const EdgeInsets.all(16),
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final message = messages[index];
                  return MessageBubbleWidget(message: message)
                      .animate().fadeIn(duration: 350.ms, delay: (index * 50).ms).slide(begin: const Offset(0, 0.1));
                },
              );
            },
          ),
        ),
        QuickRepliesWidget(onTap: (text) {
          _inputController.text = text;
          widget.controller.send(text);
        }),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _inputController,
                  decoration: InputDecoration(hintText: t.translate('ai_chat_hint')),
                ),
              ),
              IconButton(
                onPressed: () {
                  widget.controller.send(_inputController.text);
                  _inputController.clear();
                },
                icon: const Icon(Icons.send),
              )
            ],
          ),
        )
      ],
    );
  }
}
