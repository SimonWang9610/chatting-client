import 'dart:async';
import 'dart:convert';

import 'package:collection/collection.dart';

enum Topic {
  chat,
  contact,
  message,
}

class EventData {
  final Topic topic;
  final String identity;
  final Map<String, dynamic> data;

  EventData({
    required this.topic,
    required this.identity,
    required this.data,
  });

  EventData copyWith({
    Topic? topic,
    String? identity,
    Map<String, dynamic>? data,
  }) {
    return EventData(
      topic: topic ?? this.topic,
      identity: identity ?? this.identity,
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'topic': topic.toString(),
      'identity': identity,
      'data': data,
    };
  }

  factory EventData.fromMap(Map<String, dynamic> map) {
    late Topic topic;

    for (final value in Topic.values) {
      if (map['topic'] == value.toString().split('.').last) {
        topic = value;
      }
    }

    return EventData(
      topic: topic,
      identity: map['identity'] ?? '',
      data: Map<String, dynamic>.from(map['data']),
    );
  }

  String toJson() => json.encode(toMap());

  factory EventData.fromJson(String source) =>
      EventData.fromMap(json.decode(source));

  @override
  String toString() =>
      'EventData(topic: $topic, identity: $identity, data: $data)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final mapEquals = const DeepCollectionEquality().equals;

    return other is EventData &&
        other.topic == topic &&
        other.identity == identity &&
        mapEquals(other.data, data);
  }

  @override
  int get hashCode => topic.hashCode ^ identity.hashCode ^ data.hashCode;

  void dispatching(Map<String, StreamController> controllers) {}
}
