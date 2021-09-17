import 'package:get/get.dart';
import 'package:router/ui/auth/auth.dart';
import 'package:router/ui/ui.dart';

class AppRoutes {
  AppRoutes._(); //this is to prevent anyone from instantiating this object

  static final routes = [
    GetPage(name: '/', page: () => const SplashUI()),
    GetPage(name: '/signin', page: () => SignInUI()),
    GetPage(name: '/routes', page: () => RoutesUI()),
    GetPage(name: '/current-route', page: () => CurrentRouteUI()),
    GetPage(name: '/waypoint/:id', page: () => WaypointUI()),
  ];
}
