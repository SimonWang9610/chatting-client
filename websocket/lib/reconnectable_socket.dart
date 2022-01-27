import 'dart:html';

import 'package:web_socket_channel/web_socket_channel.dart';

class WebScoketController {
  static const defaultUrl = 'ws://localhost:8080';

  static final WebScoketController? _singleton =
      WebScoketController._internal();

  WebSocketChannel? _channel;
  String? _id;

  WebScoketController._internal({String? uri, String? id}) {
    _id = id ?? DateTime.now().toString();

    _channel = WebSocketChannel.connect(Uri.parse((uri ?? defaultUrl)));
  }

  factory WebScoketController(String uri, String? id) {
    return WebScoketController._internal(uri: uri, id: id);
  }

  String? get id => _id;
}
