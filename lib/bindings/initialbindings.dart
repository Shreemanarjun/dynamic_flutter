import 'package:dynamic_flutter/controllers/jsoncontroller.dart';
import 'package:dynamic_flutter/controllers/registerpagecontroller.dart';
import 'package:dynamic_flutter/services/dbservice.dart';

import 'package:get/get.dart';

class InitialBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DBService());
    Get.put(JsonController());
    Get.put(RegisterPageController());
  }
}
