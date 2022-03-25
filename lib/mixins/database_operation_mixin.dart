import '../storage/database_controller.dart';
import '../pools/base_pool.dart';

mixin DatabaseOperationMixin<T> on BasePool<T> {
  Future<int?> upsert(T data) => DatabaseProvider.instance.upsert(data);

  Future<bool> deleteById(String id) =>
      DatabaseProvider.instance.deleteById(topic, id);

  Future<T?> findById(String? id) async {
    if (id == null) return null;
    return DatabaseProvider.instance.findById<T>(id);
  }

  Future<List<String>?> queryMany({String? chatId}) =>
      DatabaseProvider.instance.queryMany<T>(chatId: chatId);

  String? getLatest({String? chatId}) =>
      DatabaseProvider.instance.queryLatest<T>(chatId: chatId);
}
