import 'package:flutter/foundation.dart';
import '../models/models.dart';

class ContactPool with ChangeNotifier {
  static final instance = ContactPool._();
  ContactPool._();

  final ContactData _pool = ContactData();

  ContactDetail? lastContact;

  void add(EventData event) {
    final contact = ContactDetail.fromMap(event.data);

    lastContact = contact;

    _pool.add(contact);

    notifyListeners();
  }

  Stream<ContactDetail> watch() {
    return _pool.subscribe();
  }

  void unwatch() {
    _pool.unsubscribe();
  }

  List<ContactDetail> get contacts => _pool.contacts;
}
