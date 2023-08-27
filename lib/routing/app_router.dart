import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/presentation/auth/login_page.dart';
import 'package:flutter_ecommerce/presentation/auth/register_page.dart';
import 'package:flutter_ecommerce/presentation/home/home_page.dart';

class AppRouter {
  Route onRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(
          builder: (context) => const HomePage(),
        );
      case "/home":
        return MaterialPageRoute(
          builder: (context) => const HomePage(),
        );
      case "/login":
        return MaterialPageRoute(
          builder: (context) => const LoginPage(),
        );
      case "/register":
        return MaterialPageRoute(
          builder: (context) => const RegisterPage(),
        );

      default:
        return MaterialPageRoute(
          builder: (context) {
            return const HomePage();
          },
        );
    }
  }
}
