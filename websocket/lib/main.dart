import 'package:flutter/material.dart';
import 'package:websocket/cache/chat_cache.dart';
import 'package:websocket/cache/contact_cache.dart';
import 'package:websocket/cache/data_cache.dart';
import 'package:websocket/cache/local_cache.dart';

import 'package:websocket/widgets/login_screen.dart';

void main() async {
  await LocalCache.init().then(() {
    DataCache.init();
    ChatCache.init();
    ContactCache.init();
  });

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginScreen(),
    );
  }
}
