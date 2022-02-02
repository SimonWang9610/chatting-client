import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:websocket/cache/data_cache.dart';

class ChatMessage {
  final String chatName;
  final String sender;
  final String text;
  final DateTime creation;
  ChatMessage({
    required this.chatName,
    required this.sender,
    required this.text,
    required this.creation,
  });

  ChatMessage copyWith({
    String? chatName,
    String? sender,
    String? text,
    DateTime? creation,
  }) {
    return ChatMessage(
      chatName: chatName ?? this.chatName,
      sender: sender ?? this.sender,
      text: text ?? this.text,
      creation: creation ?? this.creation,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'chatName': chatName,
      'sender': sender,
      'text': text,
      'creation': creation.millisecondsSinceEpoch,
    };
  }

  factory ChatMessage.fromMap(Map<String, dynamic> map) {
    return ChatMessage(
      chatName: map['chatName'] ?? '',
      sender: map['sender'] ?? '',
      text: map['text'] ?? '',
      creation: DateTime.fromMillisecondsSinceEpoch(map['creation']),
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatMessage.fromJson(String source) =>
      ChatMessage.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ChatMessage(chatName: $chatName, sender: $sender, text: $text, creation: $creation)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ChatMessage &&
        other.chatName == chatName &&
        other.sender == sender &&
        other.text == text &&
        other.creation == creation;
  }

  @override
  int get hashCode {
    return chatName.hashCode ^
        sender.hashCode ^
        text.hashCode ^
        creation.hashCode;
  }
}

class ChatData {
  final String chatId;
  final List<ChatMessage> messages;
  int unreadCount = 0;
  bool _hasSubscription = false;
  List<ChatMessage> reversedMessages = [];

  ChatData(this.chatId, this.messages, {bool hasSubcription = false})
      : _hasSubscription = hasSubcription;

  set hasSubscription(bool value) => _hasSubscription = value;

  void add(ChatMessage msg) {
    messages.add(msg);

    if (!_hasSubscription && msg.sender != DataCache.instance.currentUser) {
      unreadCount += 1;
    }
  }

  void resetunreadCount() => unreadCount = 0;

  void addAll(List<ChatMessage> msgs) {
    messages.addAll(msgs);

    if (!_hasSubscription) {
      unreadCount += msgs.length;
    }
  }

  List<ChatMessage> historyMessages(int start, [int step = 10]) {
    if (reversedMessages.isEmpty || reversedMessages.length < messages.length) {
      reversedMessages = messages.reversed.toList();
    }

    final end = start + step < reversedMessages.length
        ? start + step
        : reversedMessages.length;

    return reversedMessages.sublist(start, end);
  }

  ChatMessage get last => messages.last;
}

class Chat {
  final String id;
  final String name;
  Chat({
    required this.id,
    required this.name,
  });

  Chat copyWith({
    String? id,
    String? name,
  }) {
    return Chat(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  factory Chat.fromMap(Map<String, dynamic> map) {
    return Chat(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Chat.fromJson(String source) => Chat.fromMap(json.decode(source));

  @override
  String toString() => 'Chat(id: $id, name: $name)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Chat && other.id == id && other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
