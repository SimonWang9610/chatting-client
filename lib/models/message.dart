import 'package:isar/isar.dart';

part 'message.g.dart';

@Collection()
class Message {
  @Id()
  int? id;

  @Index(unique: true)
  late String messageId;

  late String chatId;
  late String type;
  late String creator;
  late DateTime created;
  late String content;
}

extension MessageFromMap on Map {
  Message get message => Message()
    ..chatId = this['chatId']
    ..created = DateTime.fromMillisecondsSinceEpoch(this['created'])
    ..creator = this['creator']
    ..messageId = this['messageId']
    ..type = this['type']
    ..content = this['content'];
}
