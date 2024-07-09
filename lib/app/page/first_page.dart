import 'package:flutter/material.dart';
import 'package:flutter_homework_8910/app/page/auth/login.dart';
import 'dart:math';

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
      duration: Duration(milliseconds: 1500),
    );
    opacityAnimation = Tween<double>(begin: 0, end: 1).animate(controller);
    slideAnimaton =
        Tween(begin: Offset(1, 1), end: Offset.zero).animate(CurvedAnimation(
      parent: controller,
      curve: Curves.ease,
    ));
    slideAnimaton01 =
        Tween(begin: Offset(-1, 0), end: Offset.zero).animate(CurvedAnimation(
      parent: controller,
      curve: Curves.ease,
    ));
    slideAnimaton02 =
        Tween(begin: Offset(-1, 0), end: Offset.zero).animate(CurvedAnimation(
      parent: controller,
      curve: Curves.ease,
    ));
    slideAnimaton03 =
        Tween(begin: Offset(1, 0), end: Offset.zero).animate(CurvedAnimation(
      parent: controller,
      curve: Curves.ease,
    ));
    slideAnimaton04 =
        Tween(begin: Offset(0, 1), end: Offset.zero).animate(CurvedAnimation(
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
    final sizeHeight = MediaQuery.of(context).size.height;
    final sizeWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: sizeHeight * 2 / 3,
                width: sizeWidth,
                decoration: const BoxDecoration(
                  color: Color(0xFFD9D9D9),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(100.0),
                    bottomRight: Radius.circular(100.0),
                  ),
                ),
                child: Column(
                  children: [
                    FadeTransition(
                      opacity: opacityAnimation,
                      child: Container(
                        height: sizeHeight * 1 / 7,
                        alignment: Alignment.bottomCenter,
                        child: const Text(
                          "Welcome to",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                    Container(
                      width: sizeWidth,
                      height: 145,
                      child: Stack(
                        children: [
                          SlideTransition(
                            position: slideAnimaton03,
                            child: Container(
                              margin: EdgeInsets.only(right: 20, bottom: 20),
                              alignment: Alignment.bottomRight,
                              width: double.infinity,
                              child: Image.asset(
                                "assets/images/logo/coin.png",
                                height: 70,
                                width: 70,
                              ),
                            ),
                          ),
                          Center(
                            child: FadeTransition(
                              opacity: opacityAnimation,
                              child: Text(
                                "SNEAKERS",
                                style: TextStyle(
                                  fontSize: 55,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          SlideTransition(
                            position: slideAnimaton02,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 40),
                              child: Align(
                                alignment: Alignment.bottomLeft,
                                child: Transform.rotate(
                                    angle: 35 * pi / 180,
                                    child: Image.asset(
                                      "assets/images/logo/firspag_03.png",
                                      width: 130,
                                      height: 130,
                                    )),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SlideTransition(
                      position: slideAnimaton01,
                      child: Image.asset(
                        "assets/images/logo/firspag_01.png",
                        width: 280,
                        height: 169,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: sizeHeight * 1 / 3,
                color: Colors.white,
                child: SlideTransition(
                  position: slideAnimaton04,
                  child: ScaleTransition(
                    scale: scaleAnimation,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            width: 105,
                            height: 40,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Register(),
                                    ));
                              },
                              child: Text(
                                "Register",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              style: OutlinedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                backgroundColor: Colors.grey[300],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 105,
                            height: 40,
                            child: OutlinedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => LoginScreen(),
                                    ));
                              },
                              child: Text(
                                "Sign in",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              style: OutlinedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                backgroundColor: Colors.grey[300],
                              ),
                            ),
                          ),
                        ]),
                  ),
                ),
              ),
            ],
          ),
          SlideTransition(
            position: slideAnimaton,
            child: Padding(
              padding: const EdgeInsets.only(top: 150, right: 30),
              child: Align(
                alignment: Alignment.centerRight,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                        child: Transform.rotate(
                            angle: -35 * pi / 180,
                            child: Image.asset(
                              "assets/images/logo/firspag_02.png",
                              width: 280,
                              height: 360,
                            ))),
                    Padding(
                      padding: const EdgeInsets.only(left: 100, top: 150),
                      child: Container(
                        width: 109,
                        height: 109,
                        decoration: const BoxDecoration(
                            color: Colors.white, shape: BoxShape.circle),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.asset(
                              "assets/images/logo/phongto.png",
                              width: 130, // Đặt kích thước phù hợp cho hình ảnh
                              height: 130,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
