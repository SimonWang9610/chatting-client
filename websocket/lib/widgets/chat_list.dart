import 'dart:async';

import 'package:flutter/material.dart';
import 'package:websocket/cache/chat_cache.dart';
import 'package:websocket/models/models.dart';
import 'package:websocket/widgets/chat_screen.dart';

class ChatList extends StatefulWidget {
  const ChatList({Key? key}) : super(key: key);

  @override
  State<ChatList> createState() => _ChatListState();
}

class _ChatListState extends State<ChatList>
    with AutomaticKeepAliveClientMixin {
  final cache = ChatCache.instance;
  List<String>? chats;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    chats = ChatCache.instance.orderedChats;

    ChatCache.instance.addListener(_updateChatList);
  }

  void _updateChatList() {
    chats = ChatCache.instance.orderedChats;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    ChatCache.instance.removeListener(_updateChatList);
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
              itemCount: chats!.length,
              itemBuilder: (context, index) {
                return ChatTile(chatId: chats![index]);
              },
            )
          : const Text('No chat found'),
    );
  }
}

class ChatTile extends StatefulWidget {
  final String chatId;
  const ChatTile({
    Key? key,
    required this.chatId,
  }) : super(key: key);

  @override
  State<ChatTile> createState() => _ChatTileState();
}

class _ChatTileState extends State<ChatTile> {
  int _unreadCount = 0;
  ChatMessage? _latestMsg;

  late final StreamSubscription _subscription;

  @override
  void initState() {
    super.initState();
    _subscription = _listenChatMessages(widget.chatId);
  }

  @override
  void dispose() {
    _subscription.cancel();
    ChatCache.instance.unsubscribe(widget.chatId);
    super.dispose();
    print('!!!${widget.chatId} disposed');
  }

  @override
  void didUpdateWidget(ChatTile oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.chatId != oldWidget.chatId) {
      _subscription.cancel();
      ChatCache.instance.unsubscribe(oldWidget.chatId);

      _subscription = _listenChatMessages(widget.chatId);
      print('@@@${oldWidget.chatId} updated to ${widget.chatId}');
    }
  }

  @override
  void deactivate() {
    super.deactivate();
    print('---${widget.chatId} deactivated');
  }

  @override
  void activate() {
    super.activate();
    print('+++${widget.chatId} activated');
  }

  StreamSubscription _listenChatMessages(String chatId) {
    return ChatCache.instance.subscribe(chatId).listen(
      (event) {
        final chatData = event.value as ChatData;

        _unreadCount = chatData.unreadCount;
        _latestMsg = chatData.last;

        if (mounted) {
          setState(() {});
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => ChatScreen(id: widget.chatId),
        ),
      ),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
                left: 16.0, right: 16.0, top: 16.0, bottom: 16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(
                  width: 16.0,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        widget.chatId,
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        _latestMsg!.msg,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyText1,
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  width: 16.0,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      _latestMsg!.time.toString(),
                      style: Theme.of(context).textTheme.overline,
                    ),
                    _unreadCount == 0
                        ? const SizedBox()
                        : Padding(
                            padding: const EdgeInsets.only(top: 16.0),
                            child: Material(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(12),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6.0,
                                  vertical: 3.0,
                                ),
                                child: Text(
                                  _unreadCount.toString(),
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .caption,
                                ),
                              ),
                            ),
                          ),
                  ],
                ),
              ],
            ),
          ),
          const Divider(
            color: Colors.black12,
          ),
        ],
      ),
    );
  }
}
