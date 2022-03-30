import 'package:flutter/material.dart';
import 'package:websocket/pools/pools.dart';
import '../../models/models.dart';
import 'chat_screen.dart';

class ChatTile extends StatelessWidget {
  final String chatId;

  const ChatTile({
    Key? key,
    required this.chatId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: ChatPool().findById(chatId),
        builder: (_, AsyncSnapshot<Chat?> snapshot) {
          if (snapshot.hasData) {
            final chat = snapshot.data!;
            final lastMsg = chat.lastMessage.value;

            return GestureDetector(
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
                    title: Text(chat.chatId),
                    subtitle: lastMsg != null
                        ? Text(lastMsg.content)
                        : const Text('No Message'),
                    leading: lastMsg != null ? Text(lastMsg.creator) : null,
                    trailing: chat.unreadCount != 0
                        ? Text('${chat.unreadCount}')
                        : null,
                  ),
                ),
              ),
              onTap: () {
                ChatPool().subscribe(chatId);

                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => ChatScreen(
                      id: chatId,
                      name: chatId,
                    ),
                  ),
                );
              },
            );
          } else {
            return const CircularProgressIndicator.adaptive();
          }
        });
  }
}
