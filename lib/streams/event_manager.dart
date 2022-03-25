import 'dart:async';

import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:websocket/pools/base_pool.dart';
import 'package:websocket/storage/local_storage.dart';
import '../storage/constants.dart';
import '../models/models.dart';
import '../pools/pools.dart';

class EventManager {
  static const String defaultUri = 'ws://localhost:8080/';

  static final EventManager instance = EventManager._internal();

  final StreamController bus = StreamController.broadcast();

  WebSocketChannel? _channel;

  StreamSubscription? _subscription;

  factory EventManager() {
    return instance;
  }

  EventManager._internal();

  static void init({String? uri}) {
    instance.close();
    connect(uri: uri);
  }

  void close() {
    _subscription?.cancel();
    _channel?.sink.close();
  }

  bool get isConnected => _channel != null && _subscription != null;

  void send(dynamic data) {
    print('sending data');
    _channel?.sink.add(data);
  }

  static void connect({String? uri}) {
    final url = uri != null
        ? Uri.parse(uri)
        : Uri.parse(defaultUri + LocalStorage.read(USER)!);

    instance._subscription?.cancel();

    print('connecting...');
    try {
      instance._channel = WebSocketChannel.connect(url);

      instance._subscription = listen(instance._channel!);

      print('connected successfully');
    } catch (e) {
      instance._subscription = null;
      Future.delayed(
        const Duration(seconds: 30),
        () => connect(uri: uri),
      );
    }
  }

  static StreamSubscription listen(WebSocketChannel channel) {
    return channel.stream.listen(
      (data) {
        final eventData = EventData.fromJson(data);

        //print('Got Event: ${eventData.toString()}');

        switch (eventData.topic) {
          case Topic.chat:
            ChatPool().handleEvent(eventData);
            break;
          case Topic.message:
            MessagePool().handleEvent(eventData);
            break;
          case Topic.contact:
            ContactPool().handleEvent(eventData);
            break;
        }
      },
      onDone: () => connect(),
      onError: (_) => connect(),
    );
  }

  void fire<T>(T event) => bus.add(event);
}
