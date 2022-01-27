import 'dart:async';

import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:websocket/cache/data_cache.dart';

import '../models/models.dart';
import '../utils/extensions.dart' show AsBroadcastController;

class SocketManager {
  static const String defaultUri = 'ws://localhost:8080/';

  static final SocketManager instance = SocketManager._internal();

  static final Map<String, StreamController> _dispatcherControllers = {};

  final WebSocketChannel _channel;

  late final StreamSubscription? _subscription;

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

    _subscription ??= _channel.stream.listen((data) {
      final streamData = ReceivedData.fromMap(data);

      // switch (streamData.type) {
      //   case MessageType.chats:
      //     dispatcherControllers['chats']?.add(streamData);
      //     break;
      //   case MessageType.contacts:
      //     dispatcherControllers['contacts']?.add(streamData);
      //     break;
      //   case MessageType.moments:
      //     dispatcherControllers['moments']?.add(streamData);
      //     break;
      // }

      for (final type in MessageType.values) {
        if (streamData.type == type) {
          _dispatcherControllers[type.toString()]?.sink.add(streamData);
        }
      }
    });
  }

  void cancel() {
    _subscription?.cancel();
    _channel.sink.close();

    for (final controller in _dispatcherControllers.values) {
      if (!controller.isClosed) controller.close();
    }
  }

  void send(dynamic data) {
    _channel.sink.add(data);
  }

  StreamController operator [](MessageType type) =>
      _dispatcherControllers[type.toString()]!;
}
