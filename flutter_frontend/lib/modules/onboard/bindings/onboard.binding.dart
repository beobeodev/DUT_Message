import 'package:flutter_frontend/data/repositories/hive_local.repository.dart';
import 'package:flutter_frontend/injector.dart';
import 'package:flutter_frontend/modules/onboard/controllers/onboard.controller.dart';
import 'package:get/get.dart';

class OnboardBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () =>
          OnboardController(localRepository: getIt.get<HiveLocalRepository>()),
    );
  }
}
