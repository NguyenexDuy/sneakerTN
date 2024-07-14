import 'dart:ui';

import 'package:flutter_homework_8910/app/data/api.dart';
import 'package:flutter_homework_8910/app/page/foget_pass.dart';
import 'package:flutter_homework_8910/app/page/register.dart';
import 'package:flutter_homework_8910/mainpage.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../../data/sharepre.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController accountController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  login(TextEditingController account, TextEditingController pass) async {
    if (account.text.isEmpty || pass.text.isEmpty) {
      const snackbar =
          SnackBar(content: Text("Vui lòng nhập tài khoản, mật khẩu"));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    } else {
      setState(() {
        isLoading = true;
      });
      //lấy token (lưu share_preference)
      String token = await APIRepository()
          .login(accountController.text, passwordController.text);
      var user = await APIRepository().current(token);
      // save share
      saveUser(user);
      //
      setState(() {
        isLoading = false;
      });
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const Mainpage()));
      return token;
    }
  }

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final sizeHeight = MediaQuery.of(context).size.height;
    final sizeWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
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
                              onPressed: () {
                                login(accountController, passwordController);
                              },
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
                Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 12),
                      child: Text(
                        "Quên mật khẩu",
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    ))
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Register(),
                    ));
              },
              child: Container(
                alignment: Alignment.topCenter,
                width: sizeWidth,
                height: 80,
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(80),
                      topRight: Radius.circular(80),
                    )),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: GestureDetector(
                    child: const Text(
                      "Don't have account? Click me 👉👈",
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ),
              ),
            ),
          ),
          isLoading
              ? Center(
                  child: Container(
                      height: 100,
                      width: 100,
                      color: Colors.grey,
                      child: LoadingAnimationWidget.hexagonDots(
                          color: Colors.white, size: 50)),
                )
              : const SizedBox()
        ],
      ),
    );
  }
}
