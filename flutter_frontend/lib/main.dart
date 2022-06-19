import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_frontend/core/router/route_manager.dart';
import 'package:flutter_frontend/generated/locales.g.dart';
import 'package:flutter_frontend/injector.dart';
import 'package:flutter_frontend/modules/base/bindings/base.binding.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

Future<void> main() async {
  await Hive.initFlutter();
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await dotenv.load();
  initDependencies();
  await FlutterDownloader.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'DUT Message',
          getPages: RouteManager.pages,
          initialRoute: RouteManager.splash,
          initialBinding: BaseBinding(),
          translationsKeys: AppTranslation.translations,
          fallbackLocale: const Locale('vi', 'VN'),
          locale: Get.deviceLocale,
        );
      },
    );
  }
}
