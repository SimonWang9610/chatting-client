import 'package:flutter/material.dart';
import 'package:websocket/storage/local_storage.dart';
import 'package:websocket/streams/event_manager.dart';
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
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  final List<ContactDetail> _onlineContacts = [];
  final List<ContactDetail> _offlineContacts = [];

  late final TabController _controller;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 2, vsync: this);

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
        _offlineContacts.remove(contact);
      } else {
        _offlineContacts.add(contact);
        _onlineContacts.remove(contact);
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
        bottom: TabBar(
          controller: _controller,
          tabs: const [
            Icon(Icons.online_prediction),
            Icon(Icons.offline_bolt),
          ],
        ),
      ),
      body: TabBarView(
        controller: _controller,
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

    EventManager.instance.close();

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
      child: Card(
        child: Container(
          width: 400,
          height: 100,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black,
            ),
          ),
          child: Text(contact.name),
        ),
      ),
      onTap: () async {
        final result = await HttpUtil.post('/chat', data: {
          'topic': 'Topic.chat',
          'name': contact.name,
          'members': [contact.name, LocalStorage.read(USER)!],
          'creator': LocalStorage.read(USER)!,
        });

        if (result['success']) {
          ChatPool.instance.newChat(result);

          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => ChatScreen(
                id: result['identity'],
                name: result['name'],
              ),
            ),
          );
        }
      },
    );
  }
}
