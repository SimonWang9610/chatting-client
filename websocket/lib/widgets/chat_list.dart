import 'package:flutter/material.dart';
import 'package:websocket/models/models.dart';

import 'chat_screen.dart';
import '../pools/pools.dart';

class ChatList extends StatefulWidget {
  const ChatList({Key? key}) : super(key: key);

  @override
  State<ChatList> createState() => _ChatListState();
}

class _ChatListState extends State<ChatList>
    with AutomaticKeepAliveClientMixin {
  List<Chat>? chats;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();

    chats = ChatPool.instance.pool;

    ChatPool.instance.addHook();
    ChatPool.instance.addListener(_updateChatList);
  }

  void _updateChatList() {
    chats = ChatPool.instance.pool;
    setState(() {});
  }

  @override
  void dispose() {
    ChatPool.instance.removeListener(_updateChatList);
    ChatPool.instance.removeHook();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat List'),
      ),
      body: chats != null && chats!.isNotEmpty
          ? ListView.builder(
              //itemExtent: 100,
              itemCount: chats!.length,
              itemBuilder: (context, index) {
                final chat = chats![index];
                final last = MessagePool.instance.lastMessage(chat.id);

                return GestureDetector(
                  key: ValueKey(chat.id),
                  child: Card(
                    child: Container(
                      width: 400,
                      height: 100,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                        ),
                      ),
                      child: ListTile(
                        title: Text(chat.id),
                        subtitle: last.msg != null
                            ? Text(last.msg!.text)
                            : const Text('No Message'),
                        leading:
                            last.msg != null ? Text(last.msg!.sender) : null,
                        trailing:
                            last.unread != 0 ? Text('${last.unread}') : null,
                      ),
                    ),
                  ),
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => ChatScreen(
                        id: chat.id,
                        name: chat.name,
                      ),
                    ),
                  ),
                );
              },
            )
          : const Text('No chat found'),
    );
  }
}
