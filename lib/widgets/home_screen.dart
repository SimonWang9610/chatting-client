import 'dart:async';

import 'package:flutter/material.dart';
import 'package:websocket/events/chat_event.dart';
import 'package:websocket/pools/chat_pool.dart';
import 'package:websocket/widgets/chat/chat_list.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:badges/badges.dart';
import '../widgets/contact_list.dart';
import '../interfaces/event_listen_ext.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final _pages = <Widget>[
    const ContactList(),
    const ChatList(),
  ];

  int _unreadCount = 0;
  late StreamSubscription<ChatEvent> _sub;

  final _controller = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _sub = context.listen((event) {
        _unreadCount = ChatPool().unreadCount;
        setState(() {});
      });
    });
  }

  @override
  void dispose() {
    _sub.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: PageView(
          children: _pages,
          controller: _controller,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Contact',
          ),
          BottomNavigationBarItem(
            icon: Badge(
              shape: BadgeShape.circle,
              position: BadgePosition.topStart(),
              borderRadius: BorderRadius.circular(100),
              child: const Icon(Icons.message),
              badgeContent: _unreadCount != 0
                  ? Container(
                      height: 5,
                      width: 5,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: Text('$_unreadCount'),
                    )
                  : null,
            ),
            label: 'Message',
          ),
        ],
        onTap: (index) {
          _controller.jumpToPage(index);
        },
      ),
    );
  }
}
