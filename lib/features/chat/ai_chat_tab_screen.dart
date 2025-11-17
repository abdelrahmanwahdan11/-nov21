import 'package:flutter/material.dart';
import '../../controllers/chat_controller.dart';
import '../../models/chat_message.dart';
import 'message_bubble_widget.dart';
import 'quick_replies_widget.dart';

class AiChatTabScreen extends StatefulWidget {
  const AiChatTabScreen({super.key, required this.controller});
  final ChatController controller;

  @override
  State<AiChatTabScreen> createState() => _AiChatTabScreenState();
}

class _AiChatTabScreenState extends State<AiChatTabScreen> {
  final _input = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: AnimatedBuilder(
                animation: widget.controller,
                builder: (_, __) => ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: widget.controller.messages.length,
                  itemBuilder: (_, i) {
                    final msg = widget.controller.messages[i];
                    return MessageBubbleWidget(message: msg);
                  },
                ),
              ),
            ),
            QuickRepliesWidget(onSelect: (text) => widget.controller.sendMessage(text)),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  Expanded(child: TextField(controller: _input, decoration: const InputDecoration(hintText: 'Ask AI...'))),
                  IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: () {
                      widget.controller.sendMessage(_input.text);
                      _input.clear();
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
