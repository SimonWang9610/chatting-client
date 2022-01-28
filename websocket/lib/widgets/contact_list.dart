import 'package:flutter/material.dart';
import 'package:websocket/cache/chat_cache.dart';
import 'package:websocket/cache/data_cache.dart';
import 'package:websocket/cache/local_cache.dart';
import 'package:websocket/streams/socket_manager.dart';
import 'package:websocket/widgets/chat_screen.dart';
import 'package:websocket/widgets/login_screen.dart';
import '../models/models.dart';
import '../cache/contact_cache.dart';
import '../utils/http_util.dart';
import '../streams/stream_dispatcher.dart';

class ContactList extends StatefulWidget {
  const ContactList({Key? key}) : super(key: key);

  @override
  State<ContactList> createState() => _ContactListState();
}

class _ContactListState extends State<ContactList>
    with AutomaticKeepAliveClientMixin {
  List<ContactDetail> _contacts = [];

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _contacts = ContactCache.instance.allContacts();

    ContactCache.instance.addListener(_updateContacts);
  }

  void _updateContacts() {
    _contacts = ContactCache.instance.allContacts();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacts'),
        actions: [
          IconButton(
            onPressed: _logout,
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: _contacts.isNotEmpty
                ? ListView.builder(
                    itemCount: _contacts.length,
                    itemBuilder: (_, index) {
                      return NewChat(contact: _contacts[index]);
                    },
                  )
                : const Text('No active users'),
          ),
        ],
      ),
    );
  }

  void _logout() {
    // flush and close LocalCache
    ChatCache.instance.close();
    ContactCache.instance.close();
    LocalCache.openedBoxes.clear();

    // close StreamDispatcher
    ChatDispatcher.instance.close();

    // close socket
    SocketManager.instance.close();

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (_) => const LoginScreen(),
      ),
      (route) => false,
    );
  }
}

class NewChat extends StatelessWidget {
  final ContactDetail contact;
  const NewChat({
    Key? key,
    required this.contact,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Text(contact.contact),
        onTap: () async {
          final result = await HttpUtil.post('/chat', data: {
            'first': DataCache.instance.currentUser,
            'second': contact.contact,
          });

          if (result['success']) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => ChatScreen(id: result['chatId']),
              ),
            );
          }
        });
  }
}
