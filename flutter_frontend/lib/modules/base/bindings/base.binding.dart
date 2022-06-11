import 'package:flutter_frontend/data/repositories/hive_local.repository.dart';
import 'package:flutter_frontend/injector.dart';
import 'package:flutter_frontend/modules/base/controllers/auth.controller.dart';
import 'package:flutter_frontend/modules/base/controllers/base.controller.dart';
import 'package:get/get.dart';

class BaseBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(
      BaseController(localRepository: getIt.get<HiveLocalRepository>()),
      permanent: true,
    );
    Get.put(
      AuthController(localRepository: getIt.get<HiveLocalRepository>()),
      permanent: true,
    );
  }
}
