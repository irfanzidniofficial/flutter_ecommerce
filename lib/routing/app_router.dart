import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/presentation/auth/login_page.dart';
import 'package:flutter_ecommerce/presentation/auth/register_page.dart';
import 'package:flutter_ecommerce/presentation/cart/cart_page.dart';
import 'package:flutter_ecommerce/presentation/checkout/checkout_page.dart';
import 'package:flutter_ecommerce/presentation/home/home_page.dart';
import 'package:flutter_ecommerce/presentation/transaction/transaction_page.dart';
import 'package:flutter_ecommerce/routing/main_nav.dart';

class AppRouter {
  Route onRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(
          builder: (context) => const MainNav(),
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
      case "/cart":
        return MaterialPageRoute(
          builder: (context) => const CartPage(),
        );
      case "/transaction":
        return MaterialPageRoute(
          builder: (context) => const TransactionPage(),
        );
         case "/checkout":
        return MaterialPageRoute(
          builder: (context) =>  CheckoutPage(),
        );

      default:
        return MaterialPageRoute(
          builder: (context) {
            return const MainNav();
          },
        );
    }
  }
}
