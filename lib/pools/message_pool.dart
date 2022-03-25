import 'package:websocket/pools/chat_pool.dart';

import '../models/models.dart';
import '../mixins/database_operation_mixin.dart';
import '../mixins/event_manager_mixin.dart';
import '../events/events.dart';
import 'base_pool.dart';

class MessagePool extends BasePool<Message>
    with EventManagerMixin<Message>, DatabaseOperationMixin<Message> {
  static final _instance = MessagePool._internal();

  factory MessagePool() => _instance;

  MessagePool._internal() : super(Topic.message);

  @override
  void handleEvent(event) async {
    final msg = event.data.message;
    final chatId = event.data['chatId'];

    switch (event.action) {
      case 'insert':
        _handleNewMessage(chatId, msg);
        break;
      case 'delete':
        _handleMessageDelete(msg);
        break;
    }
  }

  void _handleNewMessage(String chatId, Message msg) async {
    final chat = await ChatPool().findById(chatId);

    if (chat != null) {
      chat.lastMessage.value = msg;
      await ChatPool().upsert(chat);
      ChatPool().updateChatList(chatId);
      await upsert(msg);

      fire(MessageEvent(chatId: chatId, message: msg));
      fire(ChatEvent(chatId: chatId));
    } else {
      // TODO: fetch remote chat
    }
  }

  void _handleMessageDelete(Message msg) async {
    await deleteById(msg.messageId);
    fire(MessageEvent(chatId: msg.chatId, message: msg, shouldRemove: true));

    final chat = await ChatPool().findById(msg.chatId);

    if (chat != null && chat.lastMessage.value == msg) {
      final lastMsgId = getLatest(chatId: chat.chatId);

      chat.lastMessage.value = await findById(lastMsgId);

      fire(
        ChatEvent(
          chatId: chat.chatId,
          action: ChatAction.update,
        ),
      );
    }
  }
}
