import 'dart:async';
import '../models/generic.dart';

abstract class BasePool<T> {
  final Topic topic;

  StreamController<T>? controller;

  BasePool(this.topic, {bool enableSubscribe = false}) {
    if (enableSubscribe) controller = StreamController();
  }

  void handleEvent(EventData event);

  void close() => controller?.close();
  void push(T data) => controller?.add(data);
}
