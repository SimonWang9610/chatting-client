import 'base_event.dart';

enum ContactAction {
  invite,
  accept,
  delete,
}

class ContactEvent extends BaseEvent {
  final String contactId;
  final ContactAction action;

  ContactEvent({
    required this.contactId,
    required this.action,
  });
}
