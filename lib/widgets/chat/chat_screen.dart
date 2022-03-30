import 'dart:async';

import 'package:flutter/material.dart';
import 'package:websocket/events/message_event.dart';
import 'package:websocket/storage/local_storage.dart';
import 'package:websocket/widgets/chat/chat_text_input.dart';
import '../../interfaces/event_listen_ext.dart';
import '../../models/models.dart';
import '../../pools/pools.dart';
import '../../storage/constants.dart';
import 'message_bubble.dart';

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
  late final StreamSubscription<MessageEvent> _msgSub;

  bool textFocusActive = false;
  List<Message> _messages = [];
  int _readCount = 0;

  @override
  void initState() {
    super.initState();

    ChatPool().subscribe(widget.id);

    _loadHistoryMessages();

    _msgSub = context.listen((event) {
      if (event.chatId == widget.id) {
        if (event.shouldRemove) {
          _messages.remove(event.message);
        } else {
          _messages.insert(0, event.message);
        }
        if (mounted) setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _msgSub.cancel();

    super.dispose();
  }

  Future<void> _loadHistoryMessages() async {
    final msgs = await MessagePool().loadMessages(widget.id);

    _messages = [..._messages, ...?msgs];
    setState(() {});
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
                          return MessageBubble(
                            message: _messages[index],
                          );
                        },
                      ),
                      onRefresh: _loadHistoryMessages,
                    )
                  : const Text('No history message'),
            ),
            const SizedBox(
              height: 16.0,
            ),
            ChatTextInput(
              chatId: widget.id,
              currentUserId: LocalStorage.read(USER),
            ),
          ],
        ),
      ),
    );
  }
}
