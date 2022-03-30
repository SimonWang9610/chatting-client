import 'dart:async';

import 'package:flutter/material.dart';
import 'package:websocket/events/chat_event.dart';
import 'package:websocket/models/models.dart';

import '../../interfaces/event_listen_ext.dart';
import '../../pools/pools.dart';

import 'chat_tile.dart';

class ChatList extends StatefulWidget {
  const ChatList({Key? key}) : super(key: key);

  @override
  State<ChatList> createState() => _ChatListState();
}

class _ChatListState extends State<ChatList>
    with AutomaticKeepAliveClientMixin {
  List<String> chats = [];
  late StreamSubscription<ChatEvent> _chatSub;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();

    chats = ChatPool().chatList;

    _chatSub = context.listen((event) {
      switch (event.action) {
        case ChatAction.insert:
          chats.insert(0, event.chatId);
          break;
        case ChatAction.delete:
          chats.remove(event.chatId);
          break;
        case ChatAction.update:
          // TODO: Handle this case.
          break;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    _chatSub.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat List'),
      ),
      body: chats.isNotEmpty
          ? ListView.builder(
              //itemExtent: 100,
              itemCount: chats.length,
              itemBuilder: (context, index) {
                return ChatTile(
                  key: ValueKey(chats[index]),
                  chatId: chats[index],
                );
              },
            )
          : const Text('No chat found'),
    );
  }
}
