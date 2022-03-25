import 'base_event.dart';
import '../models/message.dart';

class MessageEvent extends BaseEvent {
  final String chatId;
  final Message message;
  final bool shouldRemove;

  MessageEvent(
      {required this.chatId, required this.message, this.shouldRemove = false});
}
