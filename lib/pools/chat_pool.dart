import 'package:flutter/cupertino.dart';
import 'package:websocket/pools/message_pool.dart';

import '../models/models.dart';

typedef ChatPoolContainer = List<Chat>;

class ChatPool with ChangeNotifier {
  static final instance = ChatPool._();

  ChatPool._();

  static void init() {
    instance.addHook();
  }

  final ChatPoolContainer _pool = [];

  // if curretnUser is the creator
  // notify the change to ChatList
  void newChat(Map<String, dynamic> map) {
    final chat = Chat.fromMap(map);

    if (!_pool.contains(chat)) {
      print('Chat Pool Event: ${chat.toString()}');
      _pool.add(chat);
      notifyListeners();
    }
  }

  void add(EventData event) {
    print('Chat Pool event: ${event.toString()}');
    final chat = Chat.fromMap(event.data);

    if (!_pool.contains(chat)) {
      _pool.add(chat);
      notifyListeners();
    }
  }

  void addHook() {
    print('hooking to MessagePool');
    MessagePool.instance.addListener(_listenEvent);
  }

  void _listenEvent() {
    print('event from message pool');
    final event = MessagePool.instance.lastEvent;

    print('chats in pooling: ${_pool.length}');

    final chat = hasChat(event!.identity);

    if (chat == null) {
      _pool.add(
        Chat(
          identity: event.identity,
          name: event.data['chatName'],
        ),
      );
    } else {
      if (chat != _pool.first) {
        _pool.remove(chat);
        _pool.insert(0, chat);
      }
    }

    notifyListeners();
  }

  ChatPoolContainer get pool => List.unmodifiable(_pool);

  void removeHook() {
    MessagePool.instance.removeListener(_listenEvent);
  }

  Chat? hasChat(String chatId) {
    for (final chat in _pool) {
      if (chat.identity == chatId) return chat;
    }
    return null;
  }

  static void close() {
    instance.removeHook();
  }
}
