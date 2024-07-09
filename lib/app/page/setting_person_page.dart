import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_homework_8910/app/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingPersonPage extends StatefulWidget {
  const SettingPersonPage({super.key});

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

  @override
  void initState() {
    super.initState();
    getDataUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chỉnh sửa thông tin cá nhân"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Ảnh đại diện",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextFormField(
                controller: imageController,
              ),
              Text(
                "ID",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextFormField(
                controller: idController,
              ),
              Text(
                "Số điện thoại",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextFormField(
                controller: phoneController,
              ),
              Text(
                "Giới tính",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextFormField(
                controller: genderController,
              ),
              Text(
                "Mã số SV",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextFormField(
                controller: masoSVController,
              ),
              Text(
                "Ngày sinh",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextFormField(
                controller: dayOfBirthController,
              ),
              Text(
                "Năm học",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextFormField(
                controller: schoolYearController,
              ),
              Text(
                "School key",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextFormField(
                controller: schoolKeyController,
              ),
              Padding(
                padding: EdgeInsets.all(12),
                child: ElevatedButton(
                    onPressed: () {}, child: Center(child: Text("Cập nhật"))),
              )
            ],
          ),
        ),
      ),
    );
  }
}
