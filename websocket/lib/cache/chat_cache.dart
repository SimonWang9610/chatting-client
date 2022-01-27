import 'package:flutter/foundation.dart';
import '../models/models.dart';
import 'local_cache.dart';

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ChatCache extends LocalCache {
  static final ChatCache instance = ChatCache._internal();
  static final _box = LocalCache.openedBoxes[MessageType.chats.toString()]!;
  String? subscriber;

  List<String> orderedChats = [];

  ChatCache._internal() : super() {
    orderedChats = getOrderedChats() ?? [];
  }

  @override
  void clear() => _box.clear();

  @override
  void close() {
    _box.put('orderedChats', orderedChats);
    _box.flush();
    _box.close();
  }

  @override
  void flush() => _box.flush();

  @override
  Stream<BoxEvent> subscribe(String key) {
    subscriber = key;
    final chatData = _box.get(key);

    if (chatData == null) {
      _box.put(key, ChatData(key, [], hasSubcription: true));
    } else {
      (chatData as ChatData).hasSubscription = true;
    }

    return _box.watch(key: key);
  }

  @override
  void unsubscribe() {
    final chatData = _box.get(subscriber) as ChatData;

    chatData.hasSubscription = false;
    subscriber = null;
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

    if (orderedChats.last != data.identity) {
      orderedChats.remove(data.identity);
      orderedChats.add(data.identity);
    }

    notifyListeners();
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
