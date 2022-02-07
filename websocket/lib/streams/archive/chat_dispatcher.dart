import 'dart:async';

import '../event_dispatcher.dart';
import '../../models/models.dart';
import '../../storage/local_storage.dart';

import '../../pools/message_pool.dart';

class ChatDispatcher extends EventDispatcher {
  static final ChatDispatcher instance = ChatDispatcher._();

  int _totalUnread = 0;

  StreamSubscription? _subscription;

  ChatDispatcher._() : super(Topic.chat);

  static void init() {
    instance._subscription = instance.stream
        .where((data) => data.identity != MessagePool.instance.subscriber)
        .listen(instance.caching);
  }

  static void close() {
    instance._subscription?.cancel();
    instance._subscription = null;
  }

  @override
  Stream<EventData> watch(String identity) {
    return stream.where((data) => data.identity == identity);
  }

  void caching(EventData event) {
    if (event.data['sender'] != LocalStorage.read('user')!) {
      _totalUnread += 1;
    }

    final msg = ChatMessage.fromMap(event.data);
  }

  int get totalUnread => _totalUnread;
}

class ChatSubscriber {
  final String chatId;
  ChatSubscriber({
    required this.chatId,
  });
}
