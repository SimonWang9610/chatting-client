import 'dart:async';

import 'package:flutter/material.dart';
import 'package:websocket/events/contact_event.dart';
import 'package:websocket/storage/local_storage.dart';
import 'package:websocket/streams/event_manager.dart';
import 'package:websocket/widgets/login_screen.dart';

import '../../pools/pools.dart';
import 'contact_tile.dart';
import '../../interfaces/event_listen_ext.dart';

class ContactList extends StatefulWidget {
  const ContactList({Key? key}) : super(key: key);

  @override
  State<ContactList> createState() => _ContactListState();
}

class _ContactListState extends State<ContactList>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  List<String> _contacts = [];

  late StreamSubscription<ContactEvent> _contactSub;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();

    _loadContacts();

    _contactSub = context.listen((event) {
      switch (event.action) {
        case ContactAction.accept:
          _contacts.remove(event.contactId);
          _contacts.insert(0, event.contactId);
          break;
        case ContactAction.invite:
          _contacts.insert(0, event.contactId);
          break;
        case ContactAction.delete:
          _contacts.remove(event.contactId);
          break;
      }

      setState(() {});
    });
  }

  void _loadContacts() async {
    final contacts = await ContactPool().queryMany();
    _contacts = [..._contacts, ...?contacts];
    setState(() {});
  }

  @override
  void dispose() {
    _contactSub.cancel();
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
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _contacts.length,
              itemBuilder: (_, index) {
                return ContactTile(
                  contactId: _contacts[index],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _logout() {
    LocalStorage.clear();

    EventManager.instance.close();

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (_) => const LoginScreen(),
      ),
      (route) => false,
    );
  }
}
