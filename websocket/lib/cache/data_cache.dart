import 'package:websocket/models/models.dart';

import 'local_cache.dart';

class DataCache extends LocalCache {
  static final DataCache instance = DataCache._internal();
  static final _box = LocalCache.openedBoxes[MessageType.data.toString()]!;

  String? _user;
  String get currentUser => _user!;

  set currentUser(String? name) => _user = name;

  DataCache._internal() : super();

  @override
  void clear() => _box.clear();

  @override
  void close() {
    clear();
    _box.close();
  }

  @override
  void flush() => _box.flush();
}
