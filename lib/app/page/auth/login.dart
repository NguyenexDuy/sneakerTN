import 'dart:ui';

import 'package:flutter_homework_8910/app/data/api.dart';
import 'package:flutter_homework_8910/app/page/foget_pass.dart';
import 'package:flutter_homework_8910/mainpage.dart';
import '../register.dart';
import 'package:flutter/material.dart';
import '../../data/sharepre.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController accountController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  login() async {
    //lấy token (lưu share_preference)
    String token = await APIRepository().login("21dh110294", "duy222222");
    var user = await APIRepository().current(token);
    // save share
    saveUser(user);
    //
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const Mainpage()));
    return token;
  }

  @override
  Widget build(BuildContext context) {
    final sizeHeight = MediaQuery.of(context).size.height;
    final sizeWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      // body: Padding(
      //   padding: EdgeInsets.all(8.0),
      //   child: Center(
      //     child: Column(
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       children: [
      //         const Text(
      //           "SNEAKER TN",
      //           style: TextStyle(
      //               color: Colors.lightBlueAccent,
      //               fontWeight: FontWeight.bold,
      //               fontSize: 30),
      //         ),
      //         const Text(
      //           "LOGIN",
      //           style: TextStyle(fontSize: 24, color: Colors.blue),
      //         ),
      //         TextFormField(
      //           controller: accountController,
      //           decoration: const InputDecoration(
      //             labelText: "Account",
      //             icon: Icon(Icons.person),
      //           ),
      //         ),
      //         const SizedBox(height: 16),
      //         TextFormField(
      //           controller: passwordController,
      //           obscureText: true,
      //           decoration: const InputDecoration(
      //             labelText: "Password",
      //             icon: Icon(Icons.password),
      //           ),
      //         ),
      //         const SizedBox(height: 10),
      //         Row(
      //           children: [
      //             Expanded(
      //                 child: ElevatedButton(
      //               onPressed: login,
      //               child: const Text("Login"),
      //             )),
      //             const SizedBox(
      //               width: 16,
      //             ),
      //             Expanded(
      //                 child: OutlinedButton(
      //               onPressed: () {
      //                 Navigator.push(
      //                     context,
      //                     MaterialPageRoute(
      //                         builder: (context) => const Register()));
      //               },
      //               child: const Text("Register"),
      //             ))
      //           ],
      //         ),
      //         const SizedBox(
      //           height: 30,
      //         ),
      //         InkWell(
      //           onTap: () {
      //             Navigator.push(
      //                 context,
      //                 MaterialPageRoute(
      //                   builder: (context) => FogetPass(),
      //                 ));
      //           },
      //           child: const Text(
      //             "Quên mật khẩu",
      //             style: TextStyle(
      //                 color: Colors.blue,
      //                 decoration: TextDecoration.underline,
      //                 decorationColor: Colors.blue),
      //           ),
      //         )
      //       ],
      //     ),
      //   ),
      // ),
      body: Stack(
        children: [
          Container(
              width: sizeWidth,
              height: double.infinity,
              child: Image.asset(
                "assets/images/logo/background.jpg",
                fit: BoxFit.cover,
              )),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 5.0, // Độ mờ theo chiều ngang
                sigmaY: 5.0, // Độ mờ theo chiều dọc
              ),
              child: Container(
                width: 200,
                height: 200,
                color: Colors.black.withOpacity(0.2), // Lớp phủ màu tùy chọn
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "SNEAKER TN",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    width: sizeWidth,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          const Text(
                            "SIGN IN",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 30),
                          ),
                          TextFormField(
                            controller: accountController,
                            decoration: const InputDecoration(
                              icon: Icon(Icons.person),
                              hintText: 'Enter your acount',
                              labelText: 'Acount',
                            ),
                          ),
                          TextFormField(
                            controller: passwordController,
                            decoration: const InputDecoration(
                              icon: Icon(Icons.password),
                              hintText: 'Enter your password',
                              labelText: 'Password',
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          OutlinedButton(
                              onPressed: login,
                              child: const Text(
                                "Sign In",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                ),
                              ))
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              alignment: Alignment.topCenter,
              width: sizeWidth,
              height: sizeHeight * 1 / 10,
              decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(80),
                    topRight: Radius.circular(80),
                  )),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const FogetPass(),
                        ));
                  },
                  child: const Text(
                    "Don't have account? Click me 👉👈",
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
