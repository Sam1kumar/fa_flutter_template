// ignore_for_file: cascade_invocations
import 'package:fa_flutter_template/app/env.dart';
import 'package:fa_flutter_template/core/network_info.dart';
import 'package:fa_flutter_template/data/local/app_db.dart';
import 'package:fa_flutter_template/data/local/sembast_app_db.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

final locator = GetIt.asNewInstance();

// [ChangeThis] Change it to required url
const String _devBaseUrl = 'https://mt-debug-appapis.fieldassist.io/api';

// [ChangeThis] Change it to required url
const String _prodBaseUrl = 'https://mtappapis.fieldassist.io/api';

// [ChangeThis] Change it to required url
const String _betaBaseUrl = 'https://mtappapis.fieldassist.io/api';

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
    // final appsPrefs = SharedAppPrefs();
    // await appsPrefs.initialise();
    // locator.registerSingleton<AppPrefs>(appsPrefs);

    /// DbHelper;
    final appDb = SembastAppDb();
    await appDb.initialise();
    locator.registerSingleton<AppDb>(appDb);

    // NetworkInfo
    locator.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(
        connectionChecker: InternetConnectionChecker(),
      ),
    );
  }
}
