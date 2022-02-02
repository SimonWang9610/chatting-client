import 'dart:async';
import 'package:websocket/cache/data_cache.dart';

import 'event_dispatcher.dart';
import '../models/generic.dart';
import '../cache/chat_cache.dart';

class ChatDispatcher extends EventDispatcher {
  static final ChatDispatcher instance = ChatDispatcher._();
  ChatSubscriber? subscriber;

  int _totalUnread = 0;

  StreamSubscription? _subscription;

  ChatDispatcher._() : super(Topic.chats);

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
  Stream<EventData> watch(String identity) {
    return stream.where((data) => data.identity == identity);
  }

  void caching(EventData event) {
    if (event.data['sender'] != DataCache.instance.currentUser) {
      _totalUnread += 1;
    }

    ChatCache.instance.cacheChatMessage(event);
    notifyListeners();
  }

  int get totalUnread => _totalUnread;
}

class ChatSubscriber {
  final String chatId;
  ChatSubscriber({
    required this.chatId,
  });
}
