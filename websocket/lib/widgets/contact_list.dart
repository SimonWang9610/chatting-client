import 'package:flutter/material.dart';
import 'package:websocket/storage/local_storage.dart';
import 'package:websocket/widgets/chat_screen.dart';
import 'package:websocket/widgets/login_screen.dart';
import '../models/models.dart';
import '../utils/http_util.dart';

import '../pools/pools.dart';
import '../storage/constants.dart';

class ContactList extends StatefulWidget {
  const ContactList({Key? key}) : super(key: key);

  @override
  State<ContactList> createState() => _ContactListState();
}

class _ContactListState extends State<ContactList>
    with AutomaticKeepAliveClientMixin {
  List<ContactDetail> _onlineContacts = [];
  List<ContactDetail> _offlineContacts = [];

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();

    for (final contact in ContactPool.instance.contacts) {
      if (contact.online) {
        _onlineContacts.add(contact);
      } else {
        _offlineContacts.add(contact);
      }
    }

    ContactPool.instance.addListener(_updateContacts);
  }

  void _updateContacts() {
    final contact = ContactPool.instance.lastContact;

    if (contact != null) {
      if (contact.online) {
        _onlineContacts.add(contact);
      } else {
        _offlineContacts.add(contact);
      }

      setState(() {});
    }
  }

  @override
  void dispose() {
    ContactPool.instance.removeListener(_updateContacts);
    super.dispose();
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
        bottom: const TabBar(
          tabs: [
            Icon(Icons.online_prediction),
            Icon(Icons.offline_bolt),
          ],
        ),
      ),
      body: TabBarView(
        children: [
          ContactTabList(contacts: _onlineContacts),
          ContactTabList(
            contacts: _offlineContacts,
          ),
        ],
      ),
    );
  }

  void _logout() {
    LocalStorage.clear();

    ChatPool.instance.removeHook();

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (_) => const LoginScreen(),
      ),
      (route) => false,
    );
  }
}

class ContactTabList extends StatelessWidget {
  final List<ContactDetail> contacts;

  const ContactTabList({
    Key? key,
    required this.contacts,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: contacts.length,
            itemBuilder: (_, index) {
              return NewChat(contact: contacts[index]);
            },
          ),
        ),
      ],
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
        child: Text(contact.name),
        onTap: () async {
          final result = await HttpUtil.post('/chat', data: {
            'topic': 'Topic.chat',
            'members': [contact.name, LocalStorage.read(USER)!]
          });

          if (result['success']) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => ChatScreen(
                  id: result['chatId'],
                  name: result['chatName'],
                ),
              ),
            );
          }
        });
  }
}
