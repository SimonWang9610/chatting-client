import 'package:websocket/cache/data_cache.dart';
import '../models/models.dart';
import 'local_cache.dart';

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ChatCache extends LocalCache {
  static final ChatCache instance = ChatCache._internal();
  static final _box = LocalCache.openedBoxes[Topic.chat.toString()]!;

  List<Chat> orderedChats = [];

  ChatCache._internal() : super();

  static void init() {
    instance.orderedChats = instance.getOrderedChats() ?? [];
  }

  static void clear() => _box.clear();

  static void close() {
    _box.put(DataCache.instance.currentUser, instance.orderedChats);
    instance.orderedChats.clear();
    _box.flush();
    _box.close();
  }

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

  void cacheChatMessage(EventData event) {
    final msg = ChatMessage.fromMap(event.data);
    final chat = Chat(id: event.identity, name: msg.chatName, members: []);

    final chatData = _box.get(event.identity);

    if (chatData == null) {
      _box.put(event.identity, ChatData(event.identity, [msg]));
    } else {
      (chatData as ChatData).add(msg);
    }
    if (orderedChats.first.id != chat.id) {
      // avoid repeated chats
      orderedChats.remove(chat);
      orderedChats.insert(0, chat);
      notifyListeners();
    }
  }

  ChatMessage? latestMessage(String chatId) {
    final chatData = _box.get(chatId);

    if (chatData != null) {
      return (chatData as ChatData).last;
    }
  }

  // get all existing chats
  List<Chat>? getOrderedChats() {
    return _box.get(DataCache.instance.currentUser);
  }

  void saveChats() => _box.put(DataCache.instance.currentUser, orderedChats);
}
