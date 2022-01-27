import 'dart:async';
import '../streams/socket_manager.dart';
import 'constants.dart';

extension AddSink on StreamController {
  void addSink(dynamic event) => SocketManager.instance.send(event);
}

extension AsBroadcastController on String {
  bool get canBroadcast {
    if (canBroadcastMessageTypes.contains(this)) {
      return true;
    } else {
      return false;
    }
  }
}
