import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../models/models.dart';

class LocalCache with ChangeNotifier {
  static final Map<String, Box<dynamic>> openedBoxes = {};

  LocalCache() {
    init();
  }

  static init() async {
    for (final type in MessageType.values) {
      if (!openedBoxes.keys.contains(type.toString())) {
        openedBoxes[type.toString()] = await Hive.openBox(type.toString());
      }
    }

    // if (!openedBoxes.containsKey('data')) {
    //   openedBoxes['data'] = await Hive.openBox('data');
    // }
  }

  close() {}
  clear() {}
  flush() {}

  Stream<dynamic>? subscribe(String key) {}
  void unsubscribe() {}
}
