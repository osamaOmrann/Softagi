import 'package:flutter/material.dart';
import 'package:softagi/layout/auth/presentation/screens/login_screen.dart';
import 'package:softagi/layout/auth/presentation/screens/register_screen.dart';
import 'package:softagi/layout/auth/presentation/screens/splash_screen.dart';
import 'package:softagi/layout/products/presentation/screens/products_screen.dart';

class Routes{
  static const String initialRoute = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String products = '/products';
}
class AppRoutes{
  static Route? generateRoute(RouteSettings routeSettings) {
    switch(routeSettings.name) {
      case Routes.initialRoute:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case Routes.login:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case Routes.register:
        return MaterialPageRoute(builder: (_) => RegisterScreen());
      case Routes.products:
        return MaterialPageRoute(builder: (_) => ProductsScreen());
      default: return MaterialPageRoute(builder: (_) => Scaffold(
        body: Center(child: Text('No routes yet..'),),
      ));
    }
  }
}