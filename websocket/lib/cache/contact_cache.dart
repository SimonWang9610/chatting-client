import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:websocket/widgets/contact_list.dart';
import '../models/models.dart';
import 'local_cache.dart';

class ContactCache extends LocalCache {
  static final ContactCache instance = ContactCache._internal();
  static final _box = LocalCache.openedBoxes[MessageType.contacts.toString()]!;

  String? subscriber;

  ContactCache._internal();

  @override
  void clear() => _box.clear();

  @override
  void close() => _box.close();

  @override
  void flush() => _box.flush();

  @override
  Stream<BoxEvent> subscribe(String key) {
    subscriber = key;

    final contacts = _box.get(key);

    if (contacts == null) {
      _box.put(key, ContactData());
    }

    return _box.watch(key: key);
  }

  @override
  void unsubscribe() {
    subscriber = null;
  }

  void addNewContact(ReceivedData data) {
    final contact = ContactDetail.fromMap(data.data);

    final contacts = _box.get('allContacts');

    if (contacts == null) {
      _box.put('allContacts', ContactData(contacts: [contact]));
    } else {
      (contacts as ContactData).add(contact);
    }

    notifyListeners();
  }

  List<ContactDetail> allContacts() {
    final contacts = _box.get('allContacts');

    if (contacts == null) {
      _box.put('allContacts', ContactData());
      return [];
    }
    return contacts.contacts;
  }
}