import 'base_event.dart';

enum ChatAction {
  insert,
  update,
  delete,
}

class ChatEvent extends BaseEvent {
  final ChatAction action;
  final String chatId;

  ChatEvent({
    required this.chatId,
    this.action = ChatAction.insert,
  });
}
