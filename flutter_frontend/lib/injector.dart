import 'package:flutter_frontend/data/datasources/remote/auth.datasource.dart';
import 'package:flutter_frontend/data/datasources/remote/conversation.datasource.dart';
import 'package:flutter_frontend/data/datasources/remote/file.datasource.dart';
import 'package:flutter_frontend/data/datasources/remote/user.datasource.dart';
import 'package:flutter_frontend/data/repositories/auth.repository.dart';
import 'package:flutter_frontend/data/repositories/conversation.repository.dart';
import 'package:flutter_frontend/data/repositories/file_repository.dart';
import 'package:flutter_frontend/data/repositories/hive_local.repository.dart';
import 'package:flutter_frontend/data/repositories/user.repository.dart';
import 'package:get_it/get_it.dart';

final GetIt getIt = GetIt.instance;

void initDependencies() {
  // Data sources
  getIt.registerLazySingleton(() => AuthRemoteDataSource());
  getIt.registerLazySingleton(() => UserRemoteDataSource());
  getIt.registerLazySingleton(() => ConversationRemoteDataSource());

  // Repository
  getIt.registerLazySingleton(() => HiveLocalRepository());
  getIt.registerLazySingleton(
    () => AuthRepository(remoteDataSource: getIt.get<AuthRemoteDataSource>()),
  );
  getIt.registerLazySingleton(
    () => ConversationRepository(
      remoteDataSource: getIt.get<ConversationRemoteDataSource>(),
    ),
  );
  getIt.registerLazySingleton(
    () => UserRepository(remoteDataSource: getIt.get<UserRemoteDataSource>()),
  );

  //* File
  getIt.registerLazySingleton(() => FileRemoteDataSource());
  getIt.registerLazySingleton(
    () =>
        FileRepository(fileRemoteDataSource: getIt.get<FileRemoteDataSource>()),
  );
}
