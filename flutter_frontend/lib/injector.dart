import 'package:flutter_frontend/data/repositories/auth.repository.dart';
import 'package:flutter_frontend/data/repositories/conversation.repository.dart';
import 'package:flutter_frontend/data/repositories/firebase_repository.dart';
import 'package:flutter_frontend/data/repositories/hive_local.repository.dart';
import 'package:flutter_frontend/data/repositories/user_repository.dart';
import 'package:get_it/get_it.dart';

final GetIt getIt = GetIt.instance;

void initDependencies() {
  getIt.registerLazySingleton(() => HiveLocalRepository());
  getIt.registerLazySingleton(() => AuthRepository());
  getIt.registerLazySingleton(() => FirebaseRepository());
  getIt.registerLazySingleton(
    () => ConversationRepository(
      localRepository: getIt.get<HiveLocalRepository>(),
    ),
  );
  getIt.registerLazySingleton(
    () => UserRepository(
      localRepository: getIt.get<HiveLocalRepository>(),
    ),
  );
}
