import 'package:hive/hive.dart';

class LocalRepository {
  static final LocalRepository _singleton = LocalRepository._init();

  LocalRepository._init() {
    //init hive with jwt box to store token
    initBoxJWTHive();
  }

  factory LocalRepository() {
    return _singleton;
  }

  //This function to init box to store token when login
  Future<void> initBoxJWTHive() async {
    await Hive.openBox('jwt');
  }
}