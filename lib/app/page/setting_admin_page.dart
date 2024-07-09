import 'package:flutter/material.dart';
import 'package:flutter_homework_8910/app/page/category_management.dart';
import 'package:flutter_homework_8910/app/page/product_management.dart';

class SettingAdminPage extends StatelessWidget {
  const SettingAdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tùy chỉnh admin"),
      ),
      body: Column(
        children: [
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CategoryManagement(),
                  ));
            },
            child: const ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.password),
                      SizedBox(
                        width: 10,
                      ),
                      Text("Quản lý loại"),
                    ],
                  ),
                  Icon(Icons.chevron_right_outlined)
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductManagement(),
                  ));
            },
            child: const ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.password),
                      SizedBox(
                        width: 10,
                      ),
                      Text("Quản lý sản phẩm"),
                    ],
                  ),
                  Icon(Icons.chevron_right_outlined)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
