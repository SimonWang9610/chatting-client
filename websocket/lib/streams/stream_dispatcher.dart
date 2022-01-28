import 'dart:async';
import 'package:websocket/utils/constants.dart';
import 'package:websocket/cache/chat_cache.dart';
import 'package:websocket/models/models.dart';
import 'package:flutter/material.dart';
import 'socket_manager.dart';
import '../widgets/chat_screen.dart';

import '../utils/extensions.dart' show AddSink;

abstract class StreamDispatcher<T> with ChangeNotifier {
  final StreamController _controller;

  StreamDispatcher(MessageType type)
      : _controller = SocketManager.instance[type];

  Stream<ReceivedData> get stream => _controller.stream.cast<ReceivedData>();

  void send(dynamic event) {
    _controller.addSink(event);
  }

  T subscribe(String identity);

  void unsubscribe();

  Stream<dynamic> watch(String identity);
}

class ChatDispatcher extends StreamDispatcher {
  static final ChatDispatcher instance = ChatDispatcher._();
  ChatSubscriber? subscriber;

  int _totalUnread = 0;

  StreamSubscription? _subscription;

  ChatDispatcher._() : super(MessageType.chats);

  static void init() {
    instance._subscription = instance.stream
        .where((data) => data.identity != instance.subscriber?.chatId)
        .listen(instance.caching);
  }

  static void close() {
    instance._subscription?.cancel();
    instance._subscription = null;
    instance.subscriber = null;
  }

  // ! problem: does stream keeps intact if we use [strea.where] twice?
  @override
  void subscribe(String identity) {
    subscriber = ChatSubscriber(
      chatId: identity,
    );
  }

  @override
  void unsubscribe() {
    subscriber = null;
  }

  @override
  Stream<ReceivedData> watch(String identity) {
    return stream.where((data) => data.identity == identity);
  }

  void caching(ReceivedData data) {
    _totalUnread += 1;

    ChatCache.instance.cacheChatMessage(data);
    notifyListeners();
  }

  int get totalUnread => _totalUnread;
}

class ChatSubscriber {
  final String chatId;
  ChatSubscriber({
    required this.chatId,
  });

  Widget get view => ChatScreen(
        id: chatId,
      );
}
