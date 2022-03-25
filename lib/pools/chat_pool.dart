import '../storage/local_storage.dart';

import 'base_pool.dart';
import '../mixins/event_manager_mixin.dart';
import '../mixins/database_operation_mixin.dart';

import '../models/models.dart';
import '../events/events.dart';

class ChatPool extends BasePool<Chat>
    with EventManagerMixin<Chat>, DatabaseOperationMixin<Chat> {
  static final _instance = ChatPool._();

  factory ChatPool() => _instance;

  ChatPool._() : super(Topic.chat);

  List<String> get chatList => LocalStorage.read('chatList') ?? [];
  set chatList(List<String> value) => LocalStorage.write('chatList', value);

  @override
  void handleEvent(event) async {
    bool isDelete = false;
    final chatId = event.data['chatId'];

    switch (event.action) {
      case 'insert':
        final chat = event.data.chat;
        await upsert(chat);
        break;
      case 'delete':
        await deleteById(chatId);
        isDelete = true;
        break;
    }

    updateChatList(chatId, isDelete);

    fire(ChatEvent(
      chatId: chatId,
      action: isDelete ? ChatAction.delete : ChatAction.insert,
    ));
  }

  void updateChatList(String chatId, [bool onlyRemove = false]) {
    final chats = chatList;
    chats.remove(chatId);

    if (!onlyRemove) chats.insert(0, chatId);
    chatList = chats;
  }
}
