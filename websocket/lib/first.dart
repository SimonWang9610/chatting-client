import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:uuid/uuid.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen>
    with AutomaticKeepAliveClientMixin {
  static final _id = Uuid().v4();
  final _channel =
      WebSocketChannel.connect(Uri.parse('ws://localhost:8080/$_id'));

  final _messageController = TextEditingController();
  final _receiverController = TextEditingController();

  @override
  bool get wantKeepAlive => false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('First Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Form(
              child: Column(
                children: [
                  TextFormField(
                    controller: _receiverController,
                    decoration: const InputDecoration(labelText: 'Reciver ID'),
                    validator: (value) {
                      if (value == null) {
                        return 'Must choose a receiver';
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    controller: _messageController,
                    decoration:
                        const InputDecoration(labelText: 'Enter your message'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            StreamBuilder(
              stream: _channel.stream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final map = json.decode(snapshot.data as String);
                  final sender = map['sender'];
                  final msg = map['msg'];

                  return Text('$sender: $msg');
                } else {
                  return const Text('Waiting anyone saying...');
                }
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _sendMessage,
        tooltip: 'Send message',
        child: const Icon(Icons.send),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void _sendMessage() {
    final Map<String, String> data = {
      'sender': _id,
      'receiver': _receiverController.text,
      'message': _messageController.text,
    };
  }

  @override
  void dispose() {
    _channel.sink.close();
    _receiverController.dispose();
    _messageController.dispose();
    super.dispose();
  }
}
