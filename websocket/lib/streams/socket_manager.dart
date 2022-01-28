import 'dart:async';

import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:websocket/cache/data_cache.dart';

import '../models/models.dart';
import '../utils/extensions.dart' show AsBroadcastController;

class SocketManager {
  static const String defaultUri = 'ws://localhost:8080/';

  static final SocketManager instance = SocketManager._internal();

  static final Map<String, StreamController> _dispatcherControllers = {};

  WebSocketChannel? _channel;

  StreamSubscription? _subscription;

  factory SocketManager() {
    return instance;
  }

  SocketManager._internal();

  static void init() {
    final dispatchers = _dispatcherControllers.keys;
    for (final type in MessageType.values) {
      final key = type.toString();

      if (!dispatchers.contains(key)) {
        _dispatcherControllers[key] = key.canBroadcast
            ? StreamController.broadcast()
            : StreamController();
      }
    }

    connect();
  }

  static void clear() {
    for (final controller in _dispatcherControllers.values) {
      if (!controller.isClosed) controller.close();
    }
    _dispatcherControllers.clear();

    instance._subscription?.cancel();
    instance._channel?.sink.close();
  }

  bool get isConnected => _channel != null && _subscription != null;

  void send(dynamic data) {
    print('sending data');
    _channel?.sink.add(data);
  }

  static void connect() {
    instance._subscription?.cancel();

    print('reconnecting...');
    try {
      instance._channel = WebSocketChannel.connect(
          Uri.parse(defaultUri + DataCache.instance.currentUser));

      instance._subscription = listen(instance._channel!);
      print('connected successfully');
    } catch (e) {
      instance._subscription = null;
      Future.delayed(
        const Duration(seconds: 30),
        () => connect(),
      );
    }
  }

  static StreamSubscription listen(WebSocketChannel channel) {
    return channel.stream.listen(
      (data) {
        final streamData = ReceivedData.fromMap(data);

        for (final type in MessageType.values) {
          if (streamData.type == type) {
            _dispatcherControllers[type.toString()]?.add(streamData);
          }
        }
      },
      onDone: () => connect(),
      onError: (_) => connect(),
    );
  }

  StreamController operator [](MessageType type) =>
      _dispatcherControllers[type.toString()]!;
}
