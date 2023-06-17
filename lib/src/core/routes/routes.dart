// ignore_for_file: unused_local_variable
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/src/core/models/product_model.dart';
import 'package:e_commerce/src/views/auth/login.dart';
import 'package:e_commerce/src/views/auth/signup.dart';
import 'package:e_commerce/src/views/dashboard/dashboard.dart';
import 'package:e_commerce/src/views/dashboard/all/all_products.dart';
import 'package:e_commerce/src/views/dashboard/fav/favorites.dart';
import 'package:e_commerce/src/views/dashboard/product_details/product_details.dart';
import 'package:e_commerce/src/views/dashboard/profile/profile.dart';
import 'package:e_commerce/src/views/dashboard/wishlist/wishlist.dart';
import 'package:e_commerce/src/views/splash/splash.dart';
import 'package:e_commerce/src/views/user_items/cart.dart';
import 'package:e_commerce/src/views/user_items/orders.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const String defaultBack = '/';
  static const String splash = '/splash';
  static const String authLogin = '/authLogin';
  static const String dashboard = '/dashboard';
  static const String all = '/all';
  static const String signup = '/signup';
  static const String favorites = '/favorites';
  static const String profile = '/profile';
  static const String productDetails = '/productDetails';
  static const String myOrders = '/myOrders';
  static const String wishlist = '/wishlist';
  static const String cart = '/cart';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    late final Object? arguments;

    if (settings.arguments != null) {
      arguments = settings.arguments;
    }

    switch (settings.name) {
      case splash:
        return MaterialPageRoute(
          builder: (context) => const Splash(),
        );
      case authLogin:
        return MaterialPageRoute(
          builder: (context) => const Login(),
        );
      case dashboard:
        return MaterialPageRoute(
          builder: (context) => const Dashboard(),
        );
      case all:
        return MaterialPageRoute(
          builder: (context) => const All(),
        );
      case signup:
        return MaterialPageRoute(
          builder: (context) => const SignUp(),
        );
      case defaultBack:
        return MaterialPageRoute(
          builder: (context) => const Splash(),
        );
      case productDetails:
        final args = settings.arguments;
        return MaterialPageRoute(
          builder: (context) => ProductDetails(
            productModel: settings.arguments as ProductModel,
          ),
        );
      case favorites:
        return MaterialPageRoute(
          builder: (context) => const Favorites(),
        );
      case wishlist:
        return MaterialPageRoute(
          builder: (context) => const Wishlist(),
        );
      case profile:
        return MaterialPageRoute(
          builder: (context) => const Profile(),
        );
      case myOrders:
        return MaterialPageRoute(
          builder: (context) => const MyOrders(),
        );
      case cart:
        return MaterialPageRoute(
          builder: (context) => const Cart(),
        );
      default:
        return MaterialPageRoute(
          builder: ((context) {
            return Scaffold(
              body: Center(
                child: Text('No routes defined for ${settings.name}'),
              ),
            );
          }),
        );
    }
  }
}
