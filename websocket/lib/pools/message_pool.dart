import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:websocket/streams/event_manager.dart';

import '../models/models.dart';

typedef MessagePoolContainer = Map<String, ChatData>;

class MessagePool with ChangeNotifier {
  static final instance = MessagePool._internal();

  MessagePool._internal();

  final MessagePoolContainer _pool = {};
  String? subscriber;
  EventData? lastEvent;

  void add(EventData event) {
    lastEvent = event;

    final msg = ChatMessage.fromMap(event.data);

    if (_pool.containsKey(event.identity)) {
      _pool[event.identity]?.add(msg);
    } else {
      _pool[event.identity] = ChatData(event.identity, [msg]);
    }

    notifyListeners();
  }

  ChatAbstract lastMessage(String chatId) {
    return _pool[chatId]!.abstract;
  }

  Stream<ChatMessage> watch(String chatId) {
    subscriber = chatId;

    if (!_pool.containsKey(chatId)) {
      _pool[chatId] = ChatData(chatId, const []);
    }

    return _pool[chatId]!.subcribe();
  }

  void unwatch() {
    subscriber = null;
    _pool[subscriber]?.unsubcribe();
  }

  void send(EventData event) {
    EventManager.instance.send(json.encode(event.toMap()));
  }

  List<ChatMessage>? loadHistory(int readCount) {
    return _pool[subscriber]?.loadHistory(readCount);
  }
}
