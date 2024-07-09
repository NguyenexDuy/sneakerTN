import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_homework_8910/app/page/setting_admin_page.dart';
import 'package:flutter_homework_8910/app/page/setting_person_page.dart';
import '../model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Detail extends StatefulWidget {
  const Detail({super.key});

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  // khi dùng tham số truyền vào phải khai báo biến trùng tên require
  User user = User.userEmpty();
  getDataUser() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String strUser = pref.getString('user')!;

    user = User.fromJson(jsonDecode(strUser));
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getDataUser();
  }

  @override
  Widget build(BuildContext context) {
    // create style
    TextStyle mystyle = const TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: Colors.amber,
    );
    return Scaffold(
      appBar: AppBar(
          title: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(user.imageURL!),
            backgroundColor: Colors.lightBlue,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              user.fullName!,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      )),
      body: SingleChildScrollView(
        // child: Center(
        //   child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        //     Image(
        //       image: NetworkImage(user.imageURL!),
        //       height: 200,
        //       width: 200,
        //     ),
        //     Text("AccoundID: ${user.accountId}", style: mystyle),
        //     Text("NumberID: ${user.idNumber}", style: mystyle),
        //     Text("Fullname: ${user.fullName}", style: mystyle),
        //     Text("Phone Number: ${user.phoneNumber}", style: mystyle),
        //     Text("Gender: ${user.gender}", style: mystyle),
        //     Text("birthDay: ${user.birthDay}", style: mystyle),
        //     Text("schoolYear: ${user.schoolYear}", style: mystyle),
        //     Text("schoolKey: ${user.schoolKey}", style: mystyle),
        //     Text("dateCreated: ${user.dateCreated}", style: mystyle),
        //   ]),
        // ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Thông tin cá nhân",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
            ),
            ListTile(
              title: Row(
                children: [
                  const Icon(Icons.account_balance),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(user.idNumber!),
                ],
              ),
            ),
            ListTile(
              title: Row(
                children: [
                  const Icon(Icons.phone),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(user.phoneNumber!),
                ],
              ),
            ),
            ListTile(
              title: Row(
                children: [
                  const Icon(Icons.transgender),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(user.gender!),
                ],
              ),
            ),
            ListTile(
              title: Row(
                children: [
                  const Icon(Icons.verified),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(user.accountId!),
                ],
              ),
            ),
            ListTile(
              title: Row(
                children: [
                  const Icon(Icons.cake),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(user.birthDay!),
                ],
              ),
            ),
            ListTile(
              title: Row(
                children: [
                  const Icon(Icons.school),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(user.schoolYear!),
                ],
              ),
            ),
            ListTile(
              title: Row(
                children: [
                  const Icon(Icons.key),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(user.schoolKey!),
                ],
              ),
            ),
            const Text(
              "Cài đặt",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SettingPersonPage(),
                    ));
              },
              child: const ListTile(
                title: Row(
                  children: [
                    Icon(Icons.settings),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Chỉnh sửa thông tin cá nhân"),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {},
              child: ListTile(
                title: Row(
                  children: [
                    const Icon(Icons.password),
                    const SizedBox(
                      width: 10,
                    ),
                    Text("Quên mật khẩu"),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SettingAdminPage(),
                    ));
              },
              child: const ListTile(
                title: Row(
                  children: [
                    Icon(Icons.admin_panel_settings),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Tùy chỉnh admin"),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
