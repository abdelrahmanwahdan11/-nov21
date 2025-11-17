enum MessageSender { user, bot }

class ChatMessage {
  ChatMessage({required this.sender, required this.text});

  final MessageSender sender;
  final String text;
}
