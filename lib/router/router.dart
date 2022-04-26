import 'package:auto_route/annotations.dart';
import 'package:fa_flutter_template/modules/common/unauthorized_page.dart';
import 'package:fa_flutter_template/modules/splash/splash_page.dart';

@MaterialAutoRouter(
  // generateNavigationHelperExtension: true,
  routes: <AutoRoute>[
    MaterialRoute(page: SplashPage, initial: true),
    MaterialRoute(page: UnauthorizedPage),
  ],
)
class $AppRouter {}
