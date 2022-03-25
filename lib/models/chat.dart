import 'dart:async';
import 'package:isar/isar.dart';

import 'message.dart';

part 'chat.g.dart';

@Collection()
class Chat {
  @Id()
  int? id;

  @Index(unique: true)
  late String chatId;
  late int unreadCount;
  late DateTime created;
  late List<String> members;
  String? chatName;

  IsarLink<Message> lastMessage = IsarLink<Message>();
}

extension ChatFromMap on Map {
  Chat get chat {
    return Chat()
      ..chatId = this['chatId']
      ..chatName = this['chatName']
      ..created = DateTime.fromMillisecondsSinceEpoch(this['created'])
      ..unreadCount = this['unreadCount'] ?? 0
      ..members = List.from(this['members'].split(','));
  }
}
