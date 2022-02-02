import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:websocket/models/models.dart';
import 'package:websocket/streams/chat_dispatcher.dart';

final streamMessageProvider = StreamProvider.autoDispose
    .family<ChatMessage, String>((ref, chatId) async* {
  final stream = ChatDispatcher.instance.watch(chatId);

  await for (final data in stream) {
    final msg = ChatMessage.fromMap(data.data);
    yield msg;
  }
});
