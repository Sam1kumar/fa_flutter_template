// ignore_for_file: cascade_invocations
import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:dio/dio.dart';
import 'package:fa_flutter_core/fa_flutter_core.dart';
import 'package:fa_flutter_template/app/env.dart';
import 'package:fa_flutter_template/core/network_info.dart';
import 'package:fa_flutter_template/data/local/app_db.dart';
import 'package:fa_flutter_template/data/local/sembast_app_db.dart';
import 'package:fa_flutter_template/data/remote/api_helper.dart';
import 'package:get_it/get_it.dart';
import 'package:imei_plugin/imei_plugin.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

final locator = GetIt.asNewInstance();

// const String _devOldBaseUrl = 'https://fa-api-debug.fieldassist.io';
const String _devBaseUrl = 'https://mt-debug-appapis.fieldassist.io/api';

// const String _prodOldBaseUrl = 'https://fa-api.fieldassist.io';
const String _prodBaseUrl = 'https://mtappapis.fieldassist.io/api';

class AppInjector {
  factory AppInjector() => _singleton;

  AppInjector._internal();

  Flavor? _flavor;

  Flavor? get flavor => _flavor;

  static final AppInjector _singleton = AppInjector._internal();



  Future<void> configure(Flavor flavor) async {
    _flavor = flavor;

    await _initRepos();
  }


  Future<void> _initRepos() async {
    // SharedPreferences
    final appsPrefs = SharedAppPrefs();
    await appsPrefs.initialise();
    locator.registerSingleton<AppPrefs>(appsPrefs);

    

    /// DbHelper;
    final appDb = SembastAppDb(
    );
    await appDb.initialise();
    locator.registerSingleton<AppDb>(appDb);

    // NetworkInfo
    locator.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(
        connectionChecker: InternetConnectionChecker(),
      ),
    );

    // ApiHelper
    final interceptors = <Interceptor>[
      
    ];

    locator.registerLazySingleton<ApiHelper>(() {
      switch (_flavor) {
        case Flavor.PROD:
          return ApiHelperImpl(
            baseUrl: _prodBaseUrl,
            interceptors: interceptors,
          );
        default:
          return ApiHelperImpl(
            baseUrl: _devBaseUrl,
            interceptors: interceptors,
          );
      }
    });

    // PackageInfo
    final packageInfo = await PackageInformationImpl.getPackageInfo();
    locator.registerLazySingleton<PackageInformation>(
      () => packageInfo,
    );

    // DeviceInfo
    if (isMobile) {
      final deviceInfo = Platform.isAndroid
          ? await DeviceInfoPlugin().androidInfo
          : await DeviceInfoPlugin().iosInfo;
      final imei = Platform.isAndroid
          ? await ImeiPlugin.getImei()
          : "ab3449fb-f95d-4ded-8d87-89a7b5689e70";
      locator.registerLazySingleton<DeviceInfo>(() {
        if (Platform.isAndroid) {
          return AndroidDeviceInfoImpl(
            androidDeviceInfo: deviceInfo as AndroidDeviceInfo,
            imeiNo: imei,
          );
        } else {
          return IosDeviceInfoImpl(
            iosDeviceInfo: deviceInfo as IosDeviceInfo,
            imeiNo: imei,
          );
        }
      });
    } else {
      locator.registerLazySingleton<DeviceInfo>(() {
        return UnknownDeviceInfoImpl();
      });
    }

  }
}
