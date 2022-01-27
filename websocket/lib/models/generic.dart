import 'dart:async';
import 'dart:convert';

import 'package:collection/collection.dart';

enum MessageType {
  chats,
  contacts,
  moments,
  data,
}

class ReceivedData {
  final MessageType type;
  final String identity;
  final Map<String, dynamic> data;

  ReceivedData({
    required this.type,
    required this.identity,
    required this.data,
  });

  ReceivedData copyWith({
    MessageType? type,
    String? identity,
    Map<String, dynamic>? data,
  }) {
    return ReceivedData(
      type: type ?? this.type,
      identity: identity ?? this.identity,
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'type': type.toString(),
      'identity': identity,
      'data': data,
    };
  }

  factory ReceivedData.fromMap(Map<String, dynamic> map) {
    late MessageType type;

    for (final value in MessageType.values) {
      if (map['type'] == value.toString().split('.').last) {
        type = value;
      }
    }

    return ReceivedData(
      type: type,
      identity: map['identity'] ?? '',
      data: Map<String, dynamic>.from(map['data']),
    );
  }

  String toJson() => json.encode(toMap());

  factory ReceivedData.fromJson(String source) =>
      ReceivedData.fromMap(json.decode(source));

  @override
  String toString() =>
      'ReceivedData(type: $type, identity: $identity, data: $data)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final mapEquals = const DeepCollectionEquality().equals;

    return other is ReceivedData &&
        other.type == type &&
        other.identity == identity &&
        mapEquals(other.data, data);
  }

  @override
  int get hashCode => type.hashCode ^ identity.hashCode ^ data.hashCode;

  void dispatching(Map<String, StreamController> controllers) {}
}
