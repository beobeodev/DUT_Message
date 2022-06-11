import 'package:flutter_frontend/data/repositories/hive_local.repository.dart';
import 'package:get/get.dart';

class BaseController extends GetxController {
  final HiveLocalRepository localRepository;

  BaseController({required this.localRepository});
}
