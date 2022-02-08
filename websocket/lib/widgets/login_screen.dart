import 'package:flutter/material.dart';
import 'package:websocket/storage/constants.dart';
import 'package:websocket/storage/local_storage.dart';
import 'package:websocket/streams/event_manager.dart';
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
        LocalStorage.write(USER, result['username']);

        EventManager.init();

        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => const HomeScreen(),
          ),
        );
      } else {
        showDialog(
          context: context,
          builder: (_) {
            return const Card(
              child: Text('Username has been taken'),
            );
          },
        );
        _focus.requestFocus();
      }
    }
  }
}
