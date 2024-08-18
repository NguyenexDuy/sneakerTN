import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_homework_8910/app/config/const.dart';
import 'package:flutter_homework_8910/app/page/auth/login.dart';
import 'package:flutter_homework_8910/app/page/register.dart';

class Firstpage extends StatefulWidget {
  const Firstpage({super.key});

  @override
  State<Firstpage> createState() => _FirstpageState();
}

class _FirstpageState extends State<Firstpage>
    with SingleTickerProviderStateMixin {
  late Animation<double> opacityAnimation;
  late AnimationController controller;
  late Animation<Offset> slideAnimaton;
  late Animation<Offset> slideAnimaton01;
  late Animation<Offset> slideAnimaton02;
  late Animation<Offset> slideAnimaton03;
  late Animation<Offset> slideAnimaton04;
  late Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    opacityAnimation = Tween<double>(begin: 0, end: 1).animate(controller);
    slideAnimaton = Tween(begin: const Offset(1, 1), end: Offset.zero)
        .animate(CurvedAnimation(
      parent: controller,
      curve: Curves.ease,
    ));
    slideAnimaton01 = Tween(begin: const Offset(-1, 0), end: Offset.zero)
        .animate(CurvedAnimation(
      parent: controller,
      curve: Curves.ease,
    ));
    slideAnimaton02 = Tween(begin: const Offset(-1, 0), end: Offset.zero)
        .animate(CurvedAnimation(
      parent: controller,
      curve: Curves.ease,
    ));
    slideAnimaton03 = Tween(begin: const Offset(1, 0), end: Offset.zero)
        .animate(CurvedAnimation(
      parent: controller,
      curve: Curves.ease,
    ));
    slideAnimaton04 = Tween(begin: const Offset(0, 1), end: Offset.zero)
        .animate(CurvedAnimation(
      parent: controller,
      curve: Curves.ease,
    ));
    scaleAnimation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
      parent: controller,
      curve: Curves.ease,
    ));
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    final sizeHeight = MediaQuery.of(context).size.height;
    final orientation = MediaQuery.of(context).orientation;

    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: orientation == Orientation.portrait
                    ? sizeHeight * 0.6
                    : sizeHeight * 0.7,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(100),
                      bottomRight: Radius.circular(100)),
                ),
                child: SafeArea(
                  child: Column(
                    children: [
                      SizedBox(
                        height: orientation == Orientation.portrait
                            ? sizeHeight * 0.6 * 3 / 5
                            : sizeHeight * 0.6,
                        width: 400,
                        child: Stack(
                          children: [
                            const Column(
                              children: [
                                Center(
                                  child: Text(
                                    "Welcome to",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                                Text(
                                  "SNEAKERS",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 50),
                                ),
                              ],
                            ),
                            SlideTransition(
                              position: slideAnimaton03,
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Transform.rotate(
                                  angle: math.pi / 12.0,
                                  child: Image.asset(
                                    img03,
                                    fit: BoxFit.contain,
                                    width: 170,
                                  ),
                                ),
                              ),
                            ),
                            SlideTransition(
                              position: slideAnimaton01,
                              child: Align(
                                alignment: const Alignment(0.3, 0.6),
                                child: Image.asset(
                                  img01,
                                  fit: BoxFit.contain,
                                  width: 170,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SlideTransition(
                position: slideAnimaton04,
                child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                          width: 120,
                          height: 50,
                          child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const LoginScreen(),
                                    ));
                              },
                              child: const Text("Sign in"))),
                      SizedBox(
                          width: 120,
                          height: 50,
                          child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const Register(),
                                    ));
                              },
                              child: const Text("Register")))
                    ],
                  ),
                ),
              )
            ],
          ),
          SlideTransition(
            position: slideAnimaton,
            child: Align(
              alignment: Alignment.centerRight,
              child: Stack(
                children: [
                  Transform.rotate(
                    angle: -math.pi / 6.0,
                    child: Image.asset(
                      img02,
                      width: 300,
                    ),
                  ),
                  Positioned(
                    right: 20,
                    top: 150,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(width: 5, color: Colors.white),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.asset(
                          phongto,
                          width: 110,
                          height: 110,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
