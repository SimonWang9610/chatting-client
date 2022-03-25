import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';

enum Topic {
  chat,
  contact,
  message,
}

class EventData {
  final Topic topic;
  final String identity;
  final String action;
  final Map<String, dynamic> data;

  EventData({
    required this.topic,
    required this.identity,
    required this.action,
    required this.data,
  });

  EventData copyWith({
    Topic? topic,
    String? identity,
    String? action,
    Map<String, dynamic>? data,
  }) {
    return EventData(
      topic: topic ?? this.topic,
      identity: identity ?? this.identity,
      action: action ?? this.action,
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'topic': topic.toString(),
      'identity': identity,
      'action': action,
      'data': data,
    };
  }

  factory EventData.fromMap(Map<String, dynamic> map) {
    late Topic topic;

    switch (map['topic']) {
      case 'chat':
        topic = Topic.chat;
        break;
      case 'message':
        topic = Topic.message;
        break;
      case 'contact':
        topic = Topic.contact;
        break;
    }

    return EventData(
      topic: topic,
      identity: map['identity'] ?? '',
      action: map['action'] ?? '',
      data: Map<String, dynamic>.from(map['data']),
    );
  }

  String toJson() => json.encode(toMap());

  factory EventData.fromJson(String source) =>
      EventData.fromMap(json.decode(source));

  @override
  String toString() {
    return 'EventData(topic: $topic, identity: $identity, action: $action, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is EventData &&
        other.topic == topic &&
        other.identity == identity &&
        other.action == action &&
        mapEquals(other.data, data);
  }

  @override
  int get hashCode {
    return topic.hashCode ^ identity.hashCode ^ action.hashCode ^ data.hashCode;
  }

  void dispatching(Map<String, StreamController> controllers) {}
}
