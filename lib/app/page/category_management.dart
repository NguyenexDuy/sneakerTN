import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_homework_8910/app/data/api.dart';
import 'package:flutter_homework_8910/app/data/sharepre.dart';
import 'package:flutter_homework_8910/app/model/category.dart';
import 'package:flutter_homework_8910/app/model/user.dart';
import 'package:flutter_homework_8910/app/page/edit_cate.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CategoryManagement extends StatefulWidget {
  const CategoryManagement({super.key});

  @override
  State<CategoryManagement> createState() => _CategoryManagementState();
}

class _CategoryManagementState extends State<CategoryManagement> {
  User user = User.userEmpty();
  bool isLoading = false;

  Future<List<Category>> getAllCate() async {
    setState(() {
      isLoading = true;
    });

    SharedPreferences pref = await SharedPreferences.getInstance();
    String strUser = pref.getString('user')!;
    String token = pref.getString("token")!;

    user = User.fromJson(jsonDecode(strUser));

    List<Category> listCate =
        await APIRepository().getCates("21dh110294", token);

    setState(() {
      isLoading = false;
    });

    print("day la chie dai cua listCate: ${listCate.length}");
    return listCate;
  }

  Future<List<Category>>? future;
  @override
  void initState() {
    future = getAllCate();
    super.initState();
  }

  void refreshCategories() {
    setState(() {
      future = getAllCate();
    });
  }

  Future<void> deleteFuncion(Category cate) async {
    print("dang vo delete funcion");
    setState(() {
      isLoading = true;
    });

    SharedPreferences preferences = await SharedPreferences.getInstance();
    String token = preferences.getString("token")!;
    User user = await getUser();
    String request = await APIRepository()
        .deleteCategory(cate, user.accountId.toString(), token);

    print(request);
    print("ket thuc delete");
    setState(() {
      future = getAllCate();
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isAdd = true;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Quản lý loại"),
      ),
      body: Stack(
        children: [
          FutureBuilder(
            future: future,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Lỗi: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('Không có sản phẩm nào'));
              }
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  var itemCate = snapshot.data![index];
                  return Padding(
                    padding: const EdgeInsets.all(12),
                    child: Container(
                      width: double.infinity,
                      height: 130,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.grey,
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: Offset(3, 5))
                          ]),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(12),
                            child: Row(
                              children: [
                                Image.network(
                                    height: 40, width: 40, itemCate.imageURL),
                                const SizedBox(
                                  width: 12,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      itemCate.name,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                    Text(itemCate.description)
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () {
                                  if (isAdd) {
                                    setState(() {
                                      isAdd = false;
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => EditCate(
                                              isAdd: isAdd,
                                              category: itemCate,
                                              refreshCategories:
                                                  refreshCategories,
                                            ),
                                          ));
                                    });
                                  }
                                },
                              ),
                              IconButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: const Text("Xác nhận xóa"),
                                          content: const Text(
                                              "Bạn có chắc chắn muốn xóa item này?"),
                                          actions: [
                                            TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: const Text("Hủy")),
                                            TextButton(
                                                onPressed: () {
                                                  deleteFuncion(itemCate);
                                                  Navigator.pop(context);
                                                },
                                                child: const Text("Xác nhận"))
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  icon: const Icon(Icons.delete))
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
          if (isLoading)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: const Center(child: CircularProgressIndicator()),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (isAdd) {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditCate(
                      isAdd: isAdd, refreshCategories: refreshCategories),
                ));
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
