import 'dart:math' as math;
import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import '../streams/stream_dispatcher.dart';
import '../cache/chat_cache.dart';
import '../cache/data_cache.dart';
import '../models/models.dart';

class ChatScreen extends StatefulWidget {
  final String id;
  const ChatScreen({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _messageController = TextEditingController();
  late final StreamSubscription _subscription;

  bool textFocusActive = false;
  List<ChatMessage> _messages = [];
  int _historyMessagesCount = 0;

  @override
  void initState() {
    super.initState();
    ChatDispatcher.instance.subscribe(widget.id);

    _messages = ChatCache.instance.readHistoryMessages(widget.id);

    _historyMessagesCount = _messages.length;

    _subscription =
        ChatCache.instance.subscribe(widget.id, true).listen((event) {
      final chatData = event.value as ChatData;

      _messages.add(chatData.last);
      setState(() {});
    });
  }

  @override
  void dispose() {
    ChatDispatcher.instance.unsubscribe();
    _subscription.cancel();
    ChatCache.instance.unsubscribe(widget.id);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // _listenStreamMessages();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.id),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: _messages.isNotEmpty
                  ? ListView.builder(
                      reverse: true,
                      shrinkWrap: true,
                      itemCount: _messages.length,
                      itemBuilder: (context, index) {
                        final msg = _messages[index];
                        return SingleMessage(
                          sender: msg.sender,
                          message: msg.msg,
                          timestamp: msg.time.toString(),
                        );
                      },
                    )
                  : const Text('No history message'),
            ),
            const SizedBox(
              height: 16.0,
            ),
            _buildInputField(),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField() {
    return Material(
      elevation: 16,
      child: Container(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: TextField(
                cursorColor: Theme.of(context).primaryColor,
                maxLines: null,
                controller: _messageController,
                onChanged: (value) {
                  textFocusActive = _messageController.text.isNotEmpty;
                  setState(() {});
                },
                decoration: InputDecoration(
                  suffixIcon: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      IconButton(
                        onPressed: () {
                          _messageController.clear();

                          final newMsg = ChatMessage(
                            sender: DataCache.instance.currentUser,
                            msg: _messageController.text,
                            time: DateTime.now().toUtc(),
                          );

                          final data = ReceivedData(
                            type: MessageType.chats,
                            identity: widget.id,
                            data: newMsg.toMap(),
                          );

                          // final data = {
                          //   'type': MessageType.chats.toString(),
                          //   'identity': widget.id,
                          //   'data': newMsg.toMap(),
                          // };

                          ChatDispatcher.instance
                              .send(json.encode(data.toMap()));
                        },
                        icon: textFocusActive
                            ? Transform.rotate(
                                angle: -90 * math.pi / 180,
                                child: Container(
                                  width: 35.0,
                                  height: 35.0,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.send,
                                    size: 20,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            : const Icon(
                                Icons.send,
                              ),
                      ),
                    ],
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 20.0),
                  hintText: 'Say something...',
                  border: InputBorder.none,
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                      width: 2.0,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _readMoreCachedMessages() {
    final historyMessages = ChatCache.instance
        .readHistoryMessages(widget.id, start: _historyMessagesCount);

    _messages = [...historyMessages, ..._messages];
    _historyMessagesCount = _historyMessagesCount + historyMessages.length;
    setState(() {});
  }
}

class SingleMessage extends StatelessWidget {
  final String sender;
  final String message;
  final String timestamp;

  const SingleMessage({
    Key? key,
    required this.sender,
    required this.message,
    required this.timestamp,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 8.0,
        top: 8.0,
        left: 16.0,
        right: 16.0,
      ),
      child: Column(
        crossAxisAlignment: DataCache.instance.currentUser == sender
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: DataCache.instance.currentUser == sender
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
            children: [
              Text(DataCache.instance.currentUser == sender ? 'You' : sender),
              const SizedBox(
                width: 8.0,
              ),
              Text(timestamp),
            ],
          ),
          const SizedBox(
            height: 8.0,
          ),
          Material(
            borderRadius: BorderRadius.only(
              bottomLeft: const Radius.circular(50),
              topLeft: DataCache.instance.currentUser == sender
                  ? const Radius.circular(50)
                  : const Radius.circular(0),
              bottomRight: const Radius.circular(50),
              topRight: DataCache.instance.currentUser == sender
                  ? const Radius.circular(0)
                  : const Radius.circular(50),
            ),
            color: DataCache.instance.currentUser == sender
                ? Colors.blue
                : Colors.white,
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Text(
                message,
                style: TextStyle(
                  color: DataCache.instance.currentUser == sender
                      ? Colors.white
                      : Colors.blue,
                  fontFamily: 'Poppins',
                  fontSize: 15,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
