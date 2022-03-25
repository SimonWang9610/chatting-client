import 'package:websocket/events/contact_event.dart';

import '../models/models.dart';
import '../mixins/database_operation_mixin.dart';
import '../mixins/event_manager_mixin.dart';
import 'base_pool.dart';

class ContactPool extends BasePool<Contact>
    with EventManagerMixin<Contact>, DatabaseOperationMixin<Contact> {
  static final _instance = ContactPool._();

  factory ContactPool() => _instance;

  ContactPool._() : super(Topic.contact);

  @override
  void handleEvent(event) async {
    final contact = event.data.contact;

    late ContactAction action;

    switch (event.action) {
      case 'invite':
        await upsert(contact);
        action = ContactAction.invite;
        break;
      case 'accept':
        await upsert(contact);
        action = ContactAction.accept;
        break;
      case 'delete':
        await deleteById(event.data['contactId']);
        action = ContactAction.delete;
        break;
    }

    fire(ContactEvent(
      contactId: contact.contactId,
      action: action,
    ));
  }
}
