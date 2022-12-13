import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';

class GetStorageHelpers {
  static void addKeyToLocalStorage(String key, dynamic value) {
    GetStorage().write(key, value);
  }
}
