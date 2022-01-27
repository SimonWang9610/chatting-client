import 'dart:convert';

class ContactDetail {
  final String contact;
  ContactDetail({
    required this.contact,
  });

  ContactDetail copyWith({
    String? contact,
  }) {
    return ContactDetail(
      contact: contact ?? this.contact,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'contact': contact,
    };
  }

  factory ContactDetail.fromMap(Map<String, dynamic> map) {
    return ContactDetail(
      contact: map['contact'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ContactDetail.fromJson(String source) =>
      ContactDetail.fromMap(json.decode(source));

  @override
  String toString() => 'ContactDetail(contact: $contact)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ContactDetail && other.contact == contact;
  }

  @override
  int get hashCode => contact.hashCode;
}

class ContactData {
  final List<ContactDetail> _contacts;
  int newContactCount = 0;
  bool _hasSubscription = false;

  ContactData({List<ContactDetail> contacts = const []}) : _contacts = contacts;

  set hasSubscription(bool value) => _hasSubscription = value;

  void add(ContactDetail contact) {
    _contacts.add(contact);

    if (!_hasSubscription) {
      newContactCount += 1;
    }
  }

  List<ContactDetail> get contacts => _contacts;
}
