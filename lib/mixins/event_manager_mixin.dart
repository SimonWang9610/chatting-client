import '../streams/event_manager.dart';
import '../pools/base_pool.dart';

mixin EventManagerMixin<T> on BasePool<T> {
  void fire<E>(E event) => EventManager.instance.fire(event);
}
