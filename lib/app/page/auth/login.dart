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
    return Scaffold(
      backgroundColor: Colors.amber,
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "SNEAKER TN",
                style: TextStyle(
                    color: Colors.lightBlueAccent,
                    fontWeight: FontWeight.bold,
                    fontSize: 30),
              ),
              const Text(
                "LOGIN",
                style: TextStyle(fontSize: 24, color: Colors.blue),
              ),
              TextFormField(
                controller: accountController,
                decoration: const InputDecoration(
                  labelText: "Account",
                  icon: Icon(Icons.person),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: "Password",
                  icon: Icon(Icons.password),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                      child: ElevatedButton(
                    onPressed: login,
                    child: const Text("Login"),
                  )),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                      child: OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Register()));
                    },
                    child: const Text("Register"),
                  ))
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FogetPass(),
                      ));
                },
                child: const Text(
                  "Quên mật khẩu",
                  style: TextStyle(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.blue),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
