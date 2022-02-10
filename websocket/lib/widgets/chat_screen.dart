import 'dart:math' as math;
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:websocket/storage/local_storage.dart';
import '../models/models.dart';
import '../pools/pools.dart';
import '../storage/constants.dart';

class ChatScreen extends StatefulWidget {
  final String id;
  final String name;
  const ChatScreen({
    Key? key,
    required this.id,
    required this.name,
  }) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _messageController = TextEditingController();
  late final StreamSubscription _subscription;

  bool textFocusActive = false;
  List<ChatMessage> _messages = [];
  int _readCount = 0;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _subscription = MessagePool.instance.watch(widget.id).listen((msg) {
        _messages.insert(0, msg);
        _readCount = _messages.length;

        if (mounted) {
          setState(() {});
        }
      });
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    MessagePool.instance.unwatch();

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
                  ? RefreshIndicator(
                      child: ListView.builder(
                        reverse: true,
                        shrinkWrap: true,
                        itemCount: _messages.length,
                        itemBuilder: (context, index) {
                          final msg = _messages[index];
                          return SingleMessage(
                            sender: msg.sender,
                            message: msg.text,
                            timestamp: msg.creation.toString(),
                          );
                        },
                      ),
                      onRefresh: _loadHsitoryMessage,
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
                          final newMsg = ChatMessage(
                            chatName: widget.name,
                            sender: LocalStorage.read(USER)!,
                            text: _messageController.text,
                            creation: DateTime.now().toUtc(),
                          );

                          final event = EventData(
                            topic: Topic.message,
                            identity: widget.id,
                            data: newMsg.toMap(),
                          );

                          _messageController.clear();

                          MessagePool.instance.send(event);
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

  Future<void> _loadHsitoryMessage() async {
    final history = MessagePool.instance.loadHistory(_readCount);

    if (history != null) {
      _messages = [..._messages, ...history];
      _readCount = _messages.length;
      setState(() {});
    }
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
        crossAxisAlignment: LocalStorage.read(USER)! == sender
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: LocalStorage.read(USER)! == sender
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
            children: [
              Text(LocalStorage.read(USER)! == sender ? 'You' : sender),
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
              topLeft: LocalStorage.read(USER)! == sender
                  ? const Radius.circular(50)
                  : const Radius.circular(0),
              bottomRight: const Radius.circular(50),
              topRight: LocalStorage.read(USER)! == sender
                  ? const Radius.circular(0)
                  : const Radius.circular(50),
            ),
            color:
                LocalStorage.read(USER)! == sender ? Colors.blue : Colors.white,
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Text(
                message,
                style: TextStyle(
                  color: LocalStorage.read(USER)! == sender
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
