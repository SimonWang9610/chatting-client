import 'dart:convert';

class ChatMessage {
  final String sender;
  final String msg;
  final DateTime time;
  ChatMessage({
    required this.sender,
    required this.msg,
    required this.time,
  });

  ChatMessage copyWith({
    String? sender,
    String? msg,
    DateTime? time,
  }) {
    return ChatMessage(
      sender: sender ?? this.sender,
      msg: msg ?? this.msg,
      time: time ?? this.time,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'sender': sender,
      'msg': msg,
      'time': time.millisecondsSinceEpoch.toString(),
    };
  }

  factory ChatMessage.fromMap(Map<String, dynamic> map) {
    return ChatMessage(
      sender: map['sender'] ?? '',
      msg: map['msg'] ?? '',
      time: DateTime.fromMillisecondsSinceEpoch(map['time']),
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatMessage.fromJson(String source) =>
      ChatMessage.fromMap(json.decode(source));

  @override
  String toString() => 'ChatMessage(sender: $sender, msg: $msg, time: $time)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ChatMessage &&
        other.sender == sender &&
        other.msg == msg &&
        other.time == time;
  }

  @override
  int get hashCode => sender.hashCode ^ msg.hashCode ^ time.hashCode;
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

    if (!_hasSubscription) {
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
