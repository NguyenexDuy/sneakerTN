import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_homework_8910/app/page/first_page.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Center(
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Lottie.asset(
                  "assets/animation/Animation - 1716364322459.json",
                  fit: BoxFit.fill),
            ),
            const Expanded(
              flex: 1,
              child: Text(
                "Sai Gon Sneaker",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
              ),
            )
          ],
        ),
      ),
      nextScreen: const Firstpage(),
      duration: 3000,
      splashIconSize: 400,
      backgroundColor: Colors.white,
    );
  }
}