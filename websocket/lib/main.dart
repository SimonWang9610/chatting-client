import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:websocket/cache/data_cache.dart';
import 'package:websocket/first.dart';
import 'package:websocket/second.dart';
import 'package:websocket/widgets/home_screen.dart';
import 'package:websocket/widgets/login_screen.dart';

void main() {
  DataCache.init();

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
