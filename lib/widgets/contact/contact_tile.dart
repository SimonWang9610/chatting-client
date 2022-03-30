import 'package:flutter/material.dart';
import 'package:websocket/models/contact.dart';
import 'package:websocket/pools/pools.dart';
import '../../utils/http_util.dart';
import '../../storage/local_storage.dart';

import '../chat/chat_screen.dart';

class ContactTile extends StatelessWidget {
  final String contactId;
  const ContactTile({
    Key? key,
    required this.contactId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: ContactPool().findById(contactId),
        builder: (_, AsyncSnapshot<Contact?> snapshot) {
          if (snapshot.hasData) {
            final contact = snapshot.data!;

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
                  child: Text(contact.nickname),
                ),
              ),
              onTap: () async {
                final result = await HttpUtil.post('/chat', data: {
                  'topic': 'Topic.chat',
                  'members': [contact.id, LocalStorage.getUserId()],
                  'creator': LocalStorage.getUserId(),
                });

                if (result['success']) {
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
          } else {
            return const CircularProgressIndicator.adaptive();
          }
        });
  }
}
