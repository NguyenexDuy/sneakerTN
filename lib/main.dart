import 'package:flutter/material.dart';
import 'package:flutter_homework_8910/app/data/cart_provider.dart';
import 'package:flutter_homework_8910/app/page/auth/login.dart';
import 'package:flutter_homework_8910/app/page/splash_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => CartProvider(),
        )
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
    // const MaterialApp(
    //   debugShowCheckedModeBanner: false,
    //   home: LoginScreen(),
    // initialRoute: "/",
    // onGenerateRoute: AppRoute.onGenerateRoute,  -> su dung auto route (pushName)
  }
}
