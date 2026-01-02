import 'package:flutter/material.dart';
import '../models/message_model.dart';
import '../data/static_data.dart';

class MessageProvider extends ChangeNotifier {
  final Map<String, List<MessageModel>> _conversations = {};
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  List<MessageModel> getConversation(String recipientId) {
    return _conversations[recipientId] ?? [];
  }

  Future<void> loadConversation(String recipientId) async {
    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 300));

    if (!_conversations.containsKey(recipientId)) {
      _conversations[recipientId] = List.from(StaticData.sampleMessages);
    }

    _isLoading = false;
    notifyListeners();
  }

  void sendMessage(String recipientId, String content) {
    final message = MessageModel(
      id: 'msg_${DateTime.now().millisecondsSinceEpoch}',
      senderId: 'user_001',
      receiverId: recipientId,
      content: content,
      timestamp: DateTime.now(),
    );

    if (!_conversations.containsKey(recipientId)) {
      _conversations[recipientId] = [];
    }
    _conversations[recipientId]!.add(message);
    notifyListeners();

    Future.delayed(const Duration(seconds: 2), () {
      final reply = MessageModel(
        id: 'msg_${DateTime.now().millisecondsSinceEpoch}',
        senderId: recipientId,
        receiverId: 'user_001',
        content: 'Thank you for your message. I will get back to you shortly.',
        timestamp: DateTime.now(),
      );
      _conversations[recipientId]!.add(reply);
      notifyListeners();
    });
  }
}