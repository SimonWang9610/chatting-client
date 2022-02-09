import 'dart:async';
import 'dart:convert';

import 'package:collection/collection.dart';

class ContactDetail {
  final String name;
  final bool online;

  ContactDetail({
    required this.name,
    required this.online,
  });

  ContactDetail copyWith({
    String? name,
    bool? online,
  }) {
    return ContactDetail(
      name: name ?? this.name,
      online: online ?? this.online,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'online': online,
    };
  }

  factory ContactDetail.fromMap(Map<String, dynamic> map) {
    return ContactDetail(
      name: map['name'] ?? '',
      online: map['online'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory ContactDetail.fromJson(String source) =>
      ContactDetail.fromMap(json.decode(source));

  @override
  String toString() => 'ContactDetail(name: $name, online: $online)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ContactDetail &&
        other.name == name &&
        other.online == online;
  }

  @override
  int get hashCode => name.hashCode ^ online.hashCode;
}

class ContactData {
  final List<ContactDetail> _contacts;
  int newContactCount = 0;
  bool _hasSubscription = false;

  StreamController? _controller;

  ContactData({List<ContactDetail>? contacts}) : _contacts = contacts ?? [];

  set hasSubscription(bool value) => _hasSubscription = value;

  void add(ContactDetail contact) {
    _contacts.add(contact);

    if (!_hasSubscription) {
      newContactCount += 1;
    }

    if (_hasSubscription) {
      _controller?.add(contact);
    }
  }

  List<ContactDetail> get contacts => _contacts;

  Stream<ContactDetail> subscribe() {
    _hasSubscription = true;
    _controller = StreamController();

    _controller?.addStream(Stream.fromIterable(_contacts));

    return _controller!.stream.cast();
  }

  void unsubscribe() {
    _hasSubscription = false;
    _controller?.close();
    _controller = null;
  }
}
