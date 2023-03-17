import 'package:bot_toast/bot_toast.dart';
import 'package:fa_flutter_template/modules/common/flavor_banner.dart';
import 'package:fa_flutter_template/router/router.gr.dart';
import 'package:flutter/material.dart';

import 'env.dart';

final appRouter = AppRouter();
final myAppNavigatorKey = appRouter.navigatorKey;

Future<T?> handleUnauthorizedUser<T>() =>
    myAppNavigatorKey.currentState!.pushNamedAndRemoveUntil<T>(
      UnauthorizedPageRoute().routeName,
      (_) => false,
    );

class MyApp extends StatefulWidget {
  const MyApp(this.env);

  final Environment env;

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return FlavorBanner(
      visible: false,
      flavor: widget.env.flavor,
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: widget.env.appTitle,
        // darkTheme: MyTheme().darkTheme,
        routerDelegate: appRouter.delegate(),
        routeInformationParser: appRouter.defaultRouteParser(),
        builder: _buildWidget,
      ),
    );
  }

  Widget _buildWidget(BuildContext context, Widget? child) {
    ErrorWidget.builder = (errorDetails) {
      return buildError(context, errorDetails);
    };
    final botToastBuilder = BotToastInit();
    final myWidget = botToastBuilder(context, child);
    return myWidget;
  }

  Widget buildError(BuildContext context, FlutterErrorDetails error) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "--Error Occurred--\n\n${error.exceptionAsString()}",
              style: const TextStyle(color: Colors.red),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 8,
            ),
          ],
        ),
      ),
    );
  }
}
