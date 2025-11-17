import 'package:flutter/foundation.dart';
import '../models/chat_message.dart';

class ChatController extends ChangeNotifier {
  final List<ChatMessage> messages = [
    ChatMessage(sender: MessageSender.bot, text: 'Welcome to Roamify AI!'),
  ];

  void sendMessage(String text) {
    messages.add(ChatMessage(sender: MessageSender.user, text: text));
    messages.add(ChatMessage(sender: MessageSender.bot, text: 'Here are some ideas for your stay.'));
    notifyListeners();
  }
}
