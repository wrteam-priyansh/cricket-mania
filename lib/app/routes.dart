import 'package:cricket_mania/ui/screens/home/homeScreen.dart';
import 'package:cricket_mania/ui/screens/loginScreen.dart';
import 'package:cricket_mania/ui/screens/splashScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Routes {
  static const String splash = "splash";
  static const String home = "/";
  static const String login = "login";

  static const String countryDetails = "countryDetails";

  static String currentRoute = splash;

  static Route<dynamic> onGenerateRoute(RouteSettings routeSettings) {
    //routeSettings.
    if (routeSettings.name == splash) {
      return CupertinoPageRoute(builder: (_) => const SplashScreen());
    }
    if (routeSettings.name == home) {
      return HomeScreen.route(routeSettings);
    }

    if (routeSettings.name == login) {
      return LoginScreen.route(routeSettings);
    }

    return CupertinoPageRoute(builder: (_) => const Scaffold());
  }
}
