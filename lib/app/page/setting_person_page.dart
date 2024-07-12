import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_homework_8910/app/data/api.dart';
import 'package:flutter_homework_8910/app/data/sharepre.dart';
import 'package:flutter_homework_8910/app/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingPersonPage extends StatefulWidget {
  const SettingPersonPage({
    super.key,
  });

  @override
  State<SettingPersonPage> createState() => _SettingPersonPageState();
}

class _SettingPersonPageState extends State<SettingPersonPage> {
  User user = User.userEmpty();
  late TextEditingController imageController;
  late TextEditingController nameController;
  late TextEditingController idController;
  late TextEditingController phoneController;
  late TextEditingController genderController;
  late TextEditingController masoSVController;
  late TextEditingController dayOfBirthController;
  late TextEditingController schoolYearController;
  late TextEditingController schoolKeyController;

  getDataUser() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String strUser = pref.getString('user')!;

    user = User.fromJson(jsonDecode(strUser));
    print(user.accountId);
    imageController = TextEditingController(text: user.imageURL);
    nameController = TextEditingController(text: user.fullName);

    idController = TextEditingController(text: user.idNumber);
    phoneController = TextEditingController(text: user.phoneNumber);
    genderController = TextEditingController(text: user.gender);
    masoSVController = TextEditingController(text: user.accountId);
    dayOfBirthController = TextEditingController(text: user.birthDay);
    schoolYearController = TextEditingController(text: user.schoolYear);
    schoolKeyController = TextEditingController(text: user.schoolKey);
    setState(() {});
  }

  void updateProfileUser() async {
    print("vao ham updat profile");
    SharedPreferences pref = await SharedPreferences.getInstance();
    String token = pref.getString("token")!;
    pref.remove("");
    User userModel = User(
      accountId: user.accountId,
      idNumber: idController.text,
      fullName: nameController.text,
      phoneNumber: phoneController.text,
      imageURL: imageController.text,
      birthDay: dayOfBirthController.text,
      gender: genderController.text,
      schoolYear: schoolYearController.text,
      schoolKey: schoolKeyController.text,
      dateCreated: user.dateCreated,
      status: user.status,
    );
    //lưu dũ liệu lại cho user
    saveUser(userModel);

    String response = await APIRepository().updateProfile(token, userModel);
    print("Trang thai respone: $response");
  }

  @override
  void initState() {
    super.initState();
    getDataUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chỉnh sửa thông tin cá nhân"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Ảnh đại diện",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextFormField(
                controller: imageController,
              ),
              const Text(
                "ID",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextFormField(
                controller: idController,
              ),
              const Text(
                "Số điện thoại",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextFormField(
                controller: phoneController,
              ),
              const Text(
                "Giới tính",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextFormField(
                controller: genderController,
              ),
              const Text(
                "Mã số SV",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextFormField(
                controller: masoSVController,
              ),
              const Text(
                "Ngày sinh",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextFormField(
                controller: dayOfBirthController,
              ),
              const Text(
                "Năm học",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextFormField(
                controller: schoolYearController,
              ),
              const Text(
                "School key",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextFormField(
                controller: schoolKeyController,
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: ElevatedButton(
                    onPressed: updateProfileUser,
                    child: const Center(child: Text("Cập nhật"))),
              )
            ],
          ),
        ),
      ),
    );
  }
}
