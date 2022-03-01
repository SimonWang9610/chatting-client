import 'package:flutter/cupertino.dart';
import 'package:websocket/pools/message_pool.dart';

import '../models/models.dart';

typedef ChatPoolContainer = List<Chat>;

class ChatPool with ChangeNotifier {
  static final instance = ChatPool._();

  ChatPool._();

  final ChatPoolContainer _pool = [];

  void newChat(Map<String, dynamic> map) {
    final chat = Chat.fromMap(map);

    if (!_pool.contains(chat)) {
      _pool.add(chat);
      notifyListeners();
    }
  }

  void add(EventData event) {
    final chat = Chat.fromMap(event.data);

    if (!_pool.contains(chat)) {
      _pool.add(chat);
      notifyListeners();
    }
  }

  void addHook() {
    MessagePool.instance.addListener(_listenEvent);
  }

  void _listenEvent() {
    final event = MessagePool.instance.lastEvent;

    if (event!.identity != _pool.first.id) {
      _pool.removeWhere((chat) => chat.id == event.identity);
      _pool.insert(
        0,
        Chat(
          id: event.identity,
          name: event.data['chatName'],
          members: event.data['members'],
        ),
      );
    }
    notifyListeners();
  }

  ChatPoolContainer get pool => List.unmodifiable(_pool);

  void removeHook() {
    MessagePool.instance.removeListener(_listenEvent);
  }
}
