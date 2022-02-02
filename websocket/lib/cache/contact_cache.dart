import 'package:hive/hive.dart';
import 'package:websocket/cache/data_cache.dart';
import '../models/models.dart';
import 'local_cache.dart';

class ContactCache extends LocalCache {
  static final ContactCache instance = ContactCache._internal();
  static final _box = LocalCache.openedBoxes[Topic.contacts.toString()]!;

  String? subscriber;

  ContactCache._internal();

  static void init() {
    instance.subscriber = null;
  }

  static void clear() => _box.clear();

  static void close() {
    flush();
    _box.close();
  }

  static void flush() => _box.flush();

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
  void unsubscribe(String key) {
    subscriber = null;
  }

  void addNewContact(EventData event) {
    final contact = ContactDetail.fromMap(event.data);

    final contacts = _box.get(DataCache.instance.currentUser);

    if (contacts == null) {
      _box.put(
          DataCache.instance.currentUser, ContactData(contacts: [contact]));
    } else {
      (contacts as ContactData).add(contact);
    }

    notifyListeners();
  }

  List<ContactDetail> allContacts() {
    final contacts = _box.get(DataCache.instance.currentUser);

    if (contacts == null) {
      _box.put(DataCache.instance.currentUser, ContactData());
      return [];
    }
    return contacts.contacts;
  }
}
