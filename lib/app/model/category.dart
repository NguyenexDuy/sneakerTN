import 'package:flutter/material.dart';
import 'package:flutter_homework_8910/app/page/auth/login.dart';

class AppRoute {
  static Route onGenerateRoute(RouteSettings route) {
    switch (route.name) {
      // case "/":
      //     return MaterialPageRoute(builder: (_) => const SplashScreen()); //-> tao 1 screen
      case "Login":
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      default:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
    }
  }

  static void pushScreen(BuildContext context, Widget route) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => route));
  }
}

class Category {
  int? idCategory;
  String name;
  String imageURL;
  String description;

  Category({
    this.idCategory,
    required this.name,
    required this.imageURL,
    required this.description,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        idCategory: json['id'],
        name: json['name'],
        imageURL: json['imageURL'],
        description: json['description'],
      );
}
