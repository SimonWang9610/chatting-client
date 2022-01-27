import 'package:flutter/material.dart';
import 'package:websocket/widgets/chat_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _pages = <Widget>[const ChatList()];

  final _controller = PageController(initialPage: 0);

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
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Contact'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Message'),
        ],
        onTap: (index) {
          _controller.jumpToPage(index);
        },
      ),
    );
  }
}
