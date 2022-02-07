import 'package:flutter/cupertino.dart';
import 'package:websocket/pools/message_pool.dart';

import '../models/models.dart';

typedef ChatPoolContainer = List<Chat>;

class ChatPool with ChangeNotifier {
  static final instance = ChatPool._();

  ChatPool._();

  final ChatPoolContainer _pool = [];

  void add(EventData event) {
    final chat = Chat.fromMap(event.data);

    _pool.add(chat);

    notifyListeners();
  }

  void addHook() {
    MessagePool.instance.addListener(_listenEvent);
  }

  void _listenEvent() {
    final event = MessagePool.instance.lastEvent;

    if (event!.identity != _pool.last.id) {
      _pool.removeWhere((chat) => chat.id == event.identity);
      _pool.add(Chat(id: event.identity, name: event.data['chatName']));
    }
    notifyListeners();
  }

  ChatPoolContainer get pool => List.unmodifiable(_pool);

  void removeHook() {
    MessagePool.instance.removeListener(_listenEvent);
  }
}
