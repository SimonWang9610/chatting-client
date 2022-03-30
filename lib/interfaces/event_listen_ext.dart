import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:websocket/events/base_event.dart';
import 'package:websocket/streams/event_manager.dart';

typedef EventHandler<T extends BaseEvent> = void Function(T event);

extension EventListenExt on BuildContext {
  StreamSubscription<T> listen<T extends BaseEvent>(EventHandler<T> handler) {
    return EventManager()
        .bus
        .stream
        .takeWhile((element) => element is T)
        .cast<T>()
        .listen(handler);
  }
}
