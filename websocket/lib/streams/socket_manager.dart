import 'dart:async';

import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:websocket/cache/data_cache.dart';

import '../models/models.dart';
import '../utils/extensions.dart' show AsBroadcastController;

class SocketManager {
  static const String defaultUri = 'ws://localhost:8080/';

  static final SocketManager instance = SocketManager._internal();

  static final Map<String, StreamController> _dispatcherControllers = {};

  WebSocketChannel _channel;

  late StreamSubscription? _subscription;

  factory SocketManager() {
    return instance;
  }

  SocketManager._internal()
      : _channel = WebSocketChannel.connect(
            Uri.parse(defaultUri + DataCache.instance.currentUser)) {
    for (final type in MessageType.values) {
      final key = type.toString();

      if (!_dispatcherControllers.keys.contains(key)) {
        _dispatcherControllers[key] = key.canBroadcast
            ? StreamController.broadcast()
            : StreamController();
      }
    }

    _subscription ??= listen(_channel);
    print('connected successfully');
  }

  bool get isConnected => _subscription != null;

  void close() {
    _subscription?.cancel();
    _channel.sink.close();

    for (final controller in _dispatcherControllers.values) {
      if (!controller.isClosed) controller.close();
    }
  }

  void send(dynamic data) {
    print('sending data');
    _channel.sink.add(data);
  }

  void reconnect() {
    _subscription?.cancel();

    print('reconnecting...');
    try {
      _channel = WebSocketChannel.connect(
          Uri.parse(defaultUri + DataCache.instance.currentUser));

      _subscription = listen(_channel);
      print('connected successfully');
    } catch (e) {
      _subscription = null;
      Future.delayed(
        const Duration(seconds: 30),
        () => reconnect(),
      );
    }
  }

  StreamSubscription listen(WebSocketChannel channel) {
    return channel.stream.listen(
      (data) {
        final streamData = ReceivedData.fromMap(data);

        for (final type in MessageType.values) {
          if (streamData.type == type) {
            _dispatcherControllers[type.toString()]?.add(streamData);
          }
        }
      },
      onDone: () => reconnect(),
      onError: (_) => reconnect(),
    );
  }

  StreamController operator [](MessageType type) =>
      _dispatcherControllers[type.toString()]!;
}
