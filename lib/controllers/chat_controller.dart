import 'package:flutter/material.dart';

import '../core/utils/dummy_data.dart';
import '../models/chat_message.dart';

class ChatController extends ChangeNotifier {
  ChatController();

  final List<ChatMessage> _messages = initialMessages();
  final ScrollController scrollController = ScrollController();

  List<ChatMessage> get messages => List.unmodifiable(_messages);

  void send(String text) {
    final trimmed = text.trim();
    if (trimmed.isEmpty) return;
    final id = DateTime.now().millisecondsSinceEpoch.toString();
    _messages.add(ChatMessage(
      id: id,
      text: trimmed,
      sentAt: DateTime.now(),
      sender: SenderType.user,
    ));
    notifyListeners();
    Future.delayed(const Duration(milliseconds: 500), () {
      _messages.add(ChatMessage(
        id: DateTime.now().add(const Duration(milliseconds: 1)).millisecondsSinceEpoch.toString(),
        text:
            'Roamify AI: I love that vibe. Let me queue two curated suites with skyline views and spa credits.',
        sentAt: DateTime.now(),
        sender: SenderType.bot,
      ));
      notifyListeners();
      _jumpToBottom();
    });
    _jumpToBottom();
  }

  void _jumpToBottom() {
    Future.delayed(const Duration(milliseconds: 200), () {
      if (!scrollController.hasClients) return;
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeOut,
      );
    });
  }
}
