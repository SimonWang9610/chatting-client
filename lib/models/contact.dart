import 'package:isar/isar.dart';

part 'contact.g.dart';

@Collection()
class Contact {
  @Id()
  int? id;

  @Index(unique: true)
  late String contactId;

  @Index(unique: true)
  late String email;
  late String nickname;
  late bool isInviter;
  String? avatar;
  DateTime? created;
  DateTime? accepted;
  bool deleted = false;
  bool isFriend = true;
}

extension ContactFromMap on Map {
  Contact get contact => Contact()
    ..email = this['email']
    ..contactId = this['contactId']
    ..created = DateTime.fromMillisecondsSinceEpoch(this['created'])
    ..nickname = this['nickname']
    ..accepted = DateTime.fromMillisecondsSinceEpoch(this['accepted'])
    ..avatar = this['avatar']
    ..isInviter = this['isInviter'];
}
