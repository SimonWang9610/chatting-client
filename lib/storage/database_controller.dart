import 'package:isar/isar.dart';
import '../models/models.dart';

typedef DBTrxWrapper = Future<void> Function();

class DatabaseProvider {
  static const _dir = 'weaver/database';

  static final instance = DatabaseProvider._();

  late final Isar _db;

  DatabaseProvider._();

  static Future<void> init({
    List<CollectionSchema<dynamic>>? schemas,
  }) async {
    instance._db = await Isar.open(
      schemas: [
        ContactSchema,
        ChatSchema,
        MessageSchema,
      ],
      directory: _dir,
    );
  }

  IsarCollection<Chat> get chats => _db.chats;
  IsarCollection<Contact> get contacts => _db.contacts;
  IsarCollection<Message> get messages => _db.messages;

  Future<void> trxWrite<T>(DBTrxWrapper handler) async {
    await handler();
  }

  Future<int?> upsert<S>(S data) async {
    switch (S) {
      case Chat:
        return chats.put(data as Chat);
      case Contact:
        return contacts.put(data as Contact);
      case Message:
        return messages.put(data as Message);
    }
  }

  Future<bool> deleteById(Topic topic, String id) async {
    switch (topic) {
      case Topic.chat:
        return chats.deleteByChatId(id);
      case Topic.contact:
        return contacts.deleteByContactId(id);
      case Topic.message:
        return messages.deleteByMessageId(id);
    }
  }

  Future<S?> findById<S>(String id) async {
    switch (S) {
      case Chat:
        return chats.where().chatIdEqualTo(id).findFirst() as Future<S?>;
      case Contact:
        return contacts.where().contactIdEqualTo(id).findFirst() as Future<S?>;
      case Message:
        return messages.where().messageIdEqualTo(id).findFirst() as Future<S?>;
    }
    return null;
  }

  Future<List<String>?> queryMany<S>({String? chatId}) async {
    switch (S) {
      case Chat:
        return chats
            .where(sort: Sort.desc)
            .sortByCreated()
            .chatIdProperty()
            .findAll();
      case Contact:
        return contacts
            .where(sort: Sort.desc)
            .sortByAccepted()
            .contactIdProperty()
            .findAll();
      case Message:
        return messages
            .where(sort: Sort.desc)
            .filter()
            .chatIdEqualTo(chatId!)
            .sortByCreated()
            .messageIdProperty()
            .findAll();
    }
  }

  String? queryLatest<S>({String? chatId}) {
    switch (S) {
      case Chat:
        return chats
            .where(sort: Sort.desc)
            .sortByCreated()
            .chatIdProperty()
            .findFirstSync();
      case Contact:
        return contacts
            .where(sort: Sort.desc)
            .sortByAccepted()
            .contactIdProperty()
            .findFirstSync();
      case Message:
        return messages
            .where(sort: Sort.desc)
            .filter()
            .chatIdEqualTo(chatId!)
            .sortByCreated()
            .messageIdProperty()
            .findFirstSync();
    }
    return null;
  }

  Future<List<Message>?> loadMessages(String chatId) async {
    return messages
        .where(sort: Sort.desc)
        .filter()
        .chatIdEqualTo(chatId)
        .sortByCreated()
        .findAll();
  }
}
