import 'dart:async';


import 'package:fa_flutter_template/app/env.dart';
import 'package:fa_flutter_ui_kit/fa_flutter_ui_kit.dart';
import 'package:flare_flutter/asset_provider.dart';
import 'package:flare_flutter/flare_cache.dart';
import 'package:flare_flutter/provider/asset_flare.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../di/injector.dart';
import 'app.dart';

final AssetProvider assetProvider = AssetFlare(
  bundle: rootBundle,
  name: Flares.SUCCESS_CHECK,
);

Future<void> _warmUpAnimations() => cachedActor(assetProvider);

Future<void> mainCommon({required Environment env}) async {
  /// If you're running an application and
  /// need to access the binary messenger before `runApp()`
  /// has been called (for example, during plugin initialization)
  /// , then you need to explicitly
  /// call the `WidgetsFlutterBinding.ensureInitialized()` first.
  /// If you're running a test,
  ///  you can call the `TestWidgetsFlutterBinding.ensureInitialized()`
  /// as the first line in your
  ///  test's `main()` method to initialize the binding.)
  WidgetsFlutterBinding.ensureInitialized();

  try {
    /// Forcing only portrait orientation
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    // Initialize Firebase App
    // if (isMobile || isWeb) {
    //   await Firebase.initializeApp();
    // }

    /// Don't prune the Flare cache, keep loaded Flare files warm and ready
    /// to be re-displayed.
    FlareCache.doesPrune = false;

    /// WarmUp Flare assets to be used directly by [FlareActor].
    await _warmUpAnimations();

    final _flavor = env.flavor;

    await AppInjector().configure(_flavor);

    /// Captures errors reported by the Flutter framework.
    FlutterError.onError = (details) {
      if (kDebugMode) {
        // In development mode, simply print to console.
        FlutterError.dumpErrorToConsole(details);
      } else {
        // In production mode,
        // report to the application zone to report to crashlytics.
        Zone.current.handleUncaughtError(details.exception, details.stack!);
      }
    };

    Future<void> _reportError(dynamic error, StackTrace stackTrace) async {
      // Print the exception to the console.

      if (kDebugMode) {
        // Print the full stacktrace in debug mode.

        return;
      } else {
        // Send the Exception and Stacktrace to crashlytics in Production mode.
      }
    }

    await runZonedGuarded<Future<void>>(
      () async {
        runApp(
          // ChangeNotifierProvider<CompanyProvider>.value(
          //   value: locator(),
          //   child: ChangeNotifierProvider(
          //     create: (_) => ThemeModel(),
          //     child: MyApp(env),
          //   ),
          // ),
          MyApp(env),
          
        );
      },
      _reportError,
    );
  } catch (e, s) {
    runApp(AppErrorPage(e));
    return;
  }
}
