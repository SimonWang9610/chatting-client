import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'data_cache.dart';
import 'chat_cache.dart';
import 'contact_cache.dart';

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
  }

  static void close() {
    DataCache.clear();
    ChatCache.close();
    ContactCache.close();

    for (final box in openedBoxes.values) {
      if (box.isOpen) box.close();
    }

    clear();
  }

  static void clear() => openedBoxes.clear();

  Stream<dynamic>? subscribe(String key) {}
  void unsubscribe(String key) {}
}
