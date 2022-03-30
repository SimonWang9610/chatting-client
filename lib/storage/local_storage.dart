import 'package:get_storage/get_storage.dart';
import 'package:websocket/storage/constants.dart';

class LocalStorage {
  static void init() async {
    await GetStorage.init();
  }

  static T? read<T>(String key) {
    return GetStorage().read<T>(key);
  }

  static void write(String key, dynamic value) {
    GetStorage().write(key, value);
  }

  static hasKey(String key) {
    GetStorage().hasData(key);
  }

  static clear() {
    GetStorage().erase();
  }

  static String getUserId() => GetStorage().read(USER);
}
