import 'package:get_storage/get_storage.dart';
import '../models/chat.dart';

class ChatStorage {
  static final instance = ChatStorage._internal();

  static final Map<String, GetStorage> boxes = {};
  ChatStorage._internal();

  static void init(List<String> chats) {
    for (final chat in chats) {
      boxes[chat] = GetStorage(chat);
    }
  }

  static void cache(String chatId, ChatMessage msg) {
    final messages = boxes[chatId]?.read(chatId);
  }
}
