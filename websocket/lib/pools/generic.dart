import 'package:flutter/cupertino.dart';

import 'package:flutter/foundation.dart';
import '../models/models.dart';

abstract class EventPool with ChangeNotifier {
  void add(EventData event);

  Stream<dynamic> subscribe(String key);
}
