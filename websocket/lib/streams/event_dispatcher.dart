import 'dart:async';
import 'package:websocket/models/models.dart';
import 'archive/socket_manager.dart';

import '../utils/extensions.dart' show AddSink;

abstract class EventDispatcher<T> {
  final StreamController _controller;

  EventDispatcher(Topic topic) : _controller = SocketManager.instance[topic];

  Stream<EventData> get stream => _controller.stream.cast<EventData>();

  void send(dynamic event) {
    _controller.addSink(event);
  }

  Stream<dynamic> watch(String identity);
}
