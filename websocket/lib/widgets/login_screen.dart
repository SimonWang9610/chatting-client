import 'package:flutter/material.dart';
import 'package:websocket/cache/chat_cache.dart';
import 'package:websocket/cache/contact_cache.dart';
import 'package:websocket/cache/data_cache.dart';
import 'package:websocket/streams/socket_manager.dart';
import 'package:websocket/streams/stream_dispatcher.dart';
import 'package:websocket/utils/http_util.dart';
import 'package:websocket/widgets/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _controller = TextEditingController();
  final _focus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 400,
        height: 400,
        child: Center(
          child: Form(
            key: _formKey,
            child: TextFormField(
              controller: _controller,
              focusNode: _focus,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter your name',
                icon: Icon(
                  Icons.people,
                  color: Colors.blue,
                ),
              ),
              validator: (v) {
                return v!.isEmpty ? 'Name required' : null;
              },
              onFieldSubmitted: (v) => _login,
            ),
          ),
        ),
      ),
    );
  }

  void _login() async {
    final form = _formKey.currentState!;

    if (!form.validate()) {
      return;
    }

    if (_controller.text.isNotEmpty) {
      final result = await HttpUtil.post(
        '/login',
        data: {'name': _controller.text},
      );

      if (result['success']) {
        DataCache.instance.currentUser = result['name'];
        SocketManager.init();
        ChatDispatcher.init();
        ContactCache.init();
        ChatCache.init();

        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => const HomeScreen(),
          ),
        );
      }
    }
  }
}
