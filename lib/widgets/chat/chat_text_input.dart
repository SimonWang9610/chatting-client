import 'package:flutter/material.dart';
import 'dart:math' as math;

import '../../pools/chat_pool.dart';

class ChatTextInput extends StatefulWidget {
  final String chatId;
  final String currentUserId;
  const ChatTextInput({
    Key? key,
    required this.chatId,
    required this.currentUserId,
  }) : super(key: key);

  @override
  State<ChatTextInput> createState() => _ChatTextInputState();
}

class _ChatTextInputState extends State<ChatTextInput> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 16,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: TextField(
              cursorColor: Theme.of(context).primaryColor,
              maxLines: null,
              controller: _controller,
              // onChanged: (value) {
              //   _msg = value;
              //   setState(() {});
              // },
              decoration: InputDecoration(
                suffixIcon: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    FlatButton(
                      onPressed: _sendMessage,
                      child: _focusNode.hasFocus
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
    );
  }

  void _sendMessage() async {
    final msg = _controller.text;

    if (msg.isEmpty) return;

    _controller.clear();

    Map<String, dynamic> data = {
      'chatId': widget.chatId,
      'type': 'text',
      'content': msg,
      'creator': widget.currentUserId,
    };

    FocusScope.of(context).unfocus();

    ChatPool().postMessage(widget.chatId, data);
  }
}
