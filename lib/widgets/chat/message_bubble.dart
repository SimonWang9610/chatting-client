import 'package:flutter/material.dart';
import 'package:websocket/models/message.dart';
import '../../storage/local_storage.dart';

class MessageBubble extends StatelessWidget {
  final Message message;

  const MessageBubble({
    Key? key,
    required this.message,
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
        crossAxisAlignment: LocalStorage.getUserId() == message.creator
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: LocalStorage.getUserId() == message.creator
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
            children: [
              Text(LocalStorage.getUserId() == message.creator
                  ? 'You'
                  : message.creator),
              const SizedBox(
                width: 8.0,
              ),
              Text(message.created.toString()),
            ],
          ),
          const SizedBox(
            height: 8.0,
          ),
          Material(
            borderRadius: BorderRadius.only(
              bottomLeft: const Radius.circular(50),
              topLeft: LocalStorage.getUserId() == message.creator
                  ? const Radius.circular(50)
                  : const Radius.circular(0),
              bottomRight: const Radius.circular(50),
              topRight: LocalStorage.getUserId() == message.creator
                  ? const Radius.circular(0)
                  : const Radius.circular(50),
            ),
            color: LocalStorage.getUserId() == message.creator
                ? Colors.blue
                : Colors.white,
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Text(
                message.content,
                style: TextStyle(
                  color: LocalStorage.getUserId() == message.creator
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
