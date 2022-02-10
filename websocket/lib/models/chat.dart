import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:websocket/storage/local_storage.dart';

import '../storage/constants.dart';

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
  StreamController? _controller;

  final String chatId;
  final List<ChatMessage> messages;
  int unreadCount = 0;
  bool _hasSubscription = false;

  ChatData(this.chatId, this.messages, {bool hasSubcription = false})
      : _hasSubscription = hasSubcription;

  set hasSubscription(bool value) => _hasSubscription = value;

  void add(ChatMessage msg) {
    messages.add(msg);

    if (!_hasSubscription) {
      if (LocalStorage.read(USER) != msg.sender) {
        unreadCount += 1;
      }
    }

    if (_hasSubscription) {
      _controller?.add(msg);
    }
  }

  void resetunreadCount() => unreadCount = 0;

  void addAll(List<ChatMessage> msgs) {
    messages.addAll(msgs);

    if (!_hasSubscription) {
      unreadCount += msgs.length;
    }
  }

  List<ChatMessage>? loadHistory(int readCount, [int step = HISTORY_STEP]) {
    final end = messages.length - readCount;
    final start = end - HISTORY_STEP > 0 ? end - HISTORY_STEP : 0;

    if (end != 0 && start != end) {
      return messages.getRange(start, end).toList();
    }
  }

  ChatAbstract get abstract {
    ChatMessage? msg;
    if (messages.isNotEmpty) {
      msg = messages.last;
    }

    return ChatAbstract(unread: unreadCount, msg: msg);
  }

  ChatMessage get last => messages.last;

  Stream<ChatMessage> subcribe() {
    _hasSubscription = true;
    _controller = StreamController();

    unreadCount = 0;

    pushHistoryMessages();

    return _controller!.stream.cast();
  }

  void unsubcribe() {
    _hasSubscription = false;
    _controller?.close();
    _controller = null;
  }

  void pushHistoryMessages() {
    final start =
        messages.length - HISTORY_STEP > 0 ? messages.length - HISTORY_STEP : 0;

    _controller?.addStream(
      Stream.fromIterable(
        messages.getRange(start, messages.length),
      ),
    );
  }
}

class ChatAbstract {
  final int unread;
  final ChatMessage? msg;

  ChatAbstract({this.unread = 0, this.msg});
}

class Chat {
  final String id;
  final String name;
  final List<String> members;
  Chat({
    required this.id,
    required this.name,
    required this.members,
  });
  ChatAbstract? description;

  Chat copyWith({
    String? id,
    String? name,
    List<String>? members,
  }) {
    return Chat(
      id: id ?? this.id,
      name: name ?? this.name,
      members: members ?? this.members,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'members': members,
    };
  }

  factory Chat.fromMap(Map<String, dynamic> map) {
    return Chat(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      members: List<String>.from(map['members']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Chat.fromJson(String source) => Chat.fromMap(json.decode(source));

  @override
  String toString() => 'Chat(id: $id, name: $name, members: $members)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Chat &&
        other.id == id &&
        other.name == name &&
        listEquals(other.members, members);
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ members.hashCode;
}
