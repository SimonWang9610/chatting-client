import 'package:flutter/material.dart';
import 'package:websocket/cache/data_cache.dart';
import 'package:websocket/widgets/chat_screen.dart';
import '../models/models.dart';
import '../cache/contact_cache.dart';
import '../utils/http_util.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({Key? key}) : super(key: key);

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen>
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
