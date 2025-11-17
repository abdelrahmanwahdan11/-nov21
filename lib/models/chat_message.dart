enum SenderType { user, bot }

class ChatMessage {
  const ChatMessage({
    required this.id,
    required this.text,
    required this.sentAt,
    required this.sender,
  });

  final String id;
  final String text;
  final DateTime sentAt;
  final SenderType sender;
}
