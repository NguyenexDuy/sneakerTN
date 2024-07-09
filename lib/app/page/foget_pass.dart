import 'package:flutter/material.dart';
import 'package:flutter_homework_8910/app/data/api.dart';

class FogetPass extends StatefulWidget {
  const FogetPass({super.key});

  @override
  State<FogetPass> createState() => _FogetPassState();
}

class _FogetPassState extends State<FogetPass> {
  forgetPass() async {
    String result = await APIRepository().fogetPass(accountIdController.text,
        numberIdController.text, newPassController.text);
    if (result == "success") {
      print(" thay doi mat khau thanh cong");
    } else {
      print("thay doi that bai");
    }
  }

  var accountIdController = TextEditingController();

  var numberIdController = TextEditingController();

  var newPassController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Quên mật khẩu"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            TextFormField(
              controller: accountIdController,
              decoration: const InputDecoration(
                labelText: "AccountID",
                prefixIcon: Icon(Icons.account_box),
              ),
            ),
            TextFormField(
              controller: numberIdController,
              decoration: const InputDecoration(
                labelText: "NumberID",
                prefixIcon: Icon(Icons.numbers),
              ),
            ),
            TextFormField(
              controller: newPassController,
              decoration: const InputDecoration(
                labelText: "NewPass",
                prefixIcon: Icon(Icons.password),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  print("Da bam doi password");
                  forgetPass();
                },
                child: const Text("Đổi password"))
          ],
        ),
      ),
    );
  }
}
