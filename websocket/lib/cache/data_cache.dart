import 'package:websocket/models/models.dart';

import 'local_cache.dart';

class DataCache extends LocalCache {
  static final DataCache instance = DataCache._internal();
  static final _box = LocalCache.openedBoxes[Topic.data.toString()]!;

  String get currentUser => _box.get('user');

  set currentUser(String? name) => _box.put('user', name);

  DataCache._internal() : super();

  static void init() {
    instance.currentUser = null;
  }

  static void clear() => _box.clear();

  static void close() {
    clear();
    _box.close();
  }

  @override
  void flush() => _box.flush();
}
