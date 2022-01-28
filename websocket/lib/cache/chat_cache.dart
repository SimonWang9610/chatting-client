import 'package:flutter/foundation.dart';
import '../models/models.dart';
import 'local_cache.dart';

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ChatCache extends LocalCache {
  static final ChatCache instance = ChatCache._internal();
  static final _box = LocalCache.openedBoxes[MessageType.chats.toString()]!;

  List<String> orderedChats = [];

  ChatCache._internal() : super();

  static void init() {
    instance.orderedChats = instance.getOrderedChats() ?? [];
  }

  static void clear() => _box.clear();

  static void close() {
    _box.put('orderedChats', instance.orderedChats);
    _box.flush();
    _box.close();
  }

  @override
  void flush() => _box.flush();

  @override
  Stream<BoxEvent> subscribe(String key, [bool stopCounting = false]) {
    final chatData = _box.get(key);

    if (chatData == null) {
      _box.put(key, ChatData(key, [], hasSubcription: stopCounting));
    } else {
      (chatData as ChatData).hasSubscription = stopCounting;
    }

    return _box.watch(key: key);
  }

  @override
  void unsubscribe(String key) {
    final chatData = _box.get(key) as ChatData;

    chatData.hasSubscription = false;
  }

  void resetUnreadCount(String chatId) {
    final chatData = _box.get(chatId) as ChatData;

    chatData.resetunreadCount();
  }

  void cacheChatMessage(ReceivedData data) {
    final msg = ChatMessage.fromMap(data.data);

    final chatData = _box.get(data.identity);

    if (chatData == null) {
      _box.put(data.identity, ChatData(data.identity, [msg]));
    } else {
      (chatData as ChatData).add(msg);
    }

    if (orderedChats.first != data.identity) {
      orderedChats.remove(data.identity);
      orderedChats.insert(0, data.identity);
      notifyListeners();
    }
  }

  List<ChatMessage> readHistoryMessages(String chatId, {int start = 0}) {
    final chatData = _box.get(chatId) as ChatData;

    chatData.resetunreadCount();

    return chatData.historyMessages(start).reversed.toList();
  }

  ChatMessage? latestMessage(String chatId) {
    final chatData = _box.get(chatId);

    if (chatData != null) {
      return (chatData as ChatData).last;
    }
  }

  // get all existing chats
  List<String>? getOrderedChats() {
    return _box.get('orderedChats');
  }

  void saveChats() => _box.put('orderedChats', orderedChats);
}
