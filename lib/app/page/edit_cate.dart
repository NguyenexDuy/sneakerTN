import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_homework_8910/app/data/api.dart';
import 'package:flutter_homework_8910/app/data/sharepre.dart';
import 'package:flutter_homework_8910/app/model/category.dart';
import 'package:flutter_homework_8910/app/model/product.dart';
import 'package:flutter_homework_8910/app/model/user.dart';
import 'package:flutter_homework_8910/app/page/category/categorywidget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditCate extends StatefulWidget {
  EditCate(
      {super.key,
      required this.isAdd,
      this.category,
      required this.refreshCategories});
  bool isAdd;
  Category? category;
  final Function refreshCategories;

  @override
  State<EditCate> createState() => _EditCateState();
}

class _EditCateState extends State<EditCate> {
  late TextEditingController imageController;
  late TextEditingController nameController;
  late TextEditingController desController;

  @override
  void initState() {
    super.initState();
    imageController = TextEditingController(
        text: widget.isAdd ? '' : widget.category?.imageURL ?? '');
    desController = TextEditingController(
        text: widget.isAdd ? '' : widget.category?.description ?? '');
    nameController = TextEditingController(
        text: widget.isAdd ? '' : widget.category?.name ?? '');
  }

  editFuncion() async {
    log("dang vo edit funcion");
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String token = preferences.getString("token")!;
    User user = await getUser();
    Category model = Category(
        idCategory: widget.category!.idCategory,
        name: nameController.text,
        imageURL: imageController.text,
        description: desController.text);
    String request = await APIRepository()
        .updateCate(model, user.accountId.toString(), token);

    log(request);
    log("ket thuc edit");
    widget.refreshCategories(); // Thực thi hàm refreshCategories
    Navigator.pop(context);
  }

  insertFuncion() async {
    print("dang vo insert funcion");
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String token = await preferences.getString("token")!;
    User user = await getUser();
    Category modell = Category(
      name: nameController.text,
      imageURL: imageController.text,
      description: desController.text,
    );
    String request = await APIRepository()
        .insertCate(modell, user.accountId.toString(), token);
    print(request);
    print("ket thuc inser");
    widget.refreshCategories();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.isAdd ? Text("Thêm") : Text("Chỉnh sửa"),
      ),
      body: Column(
        children: [
          Row(
            children: [
              const Text("Image url: "),
              Expanded(
                child: TextFormField(
                  controller: imageController,
                ),
              )
            ],
          ),
          Row(
            children: [
              const Text("name cate: "),
              Expanded(
                child: TextFormField(
                  controller: nameController,
                ),
              )
            ],
          ),
          Row(
            children: [
              const Text("description "),
              Expanded(
                child: TextFormField(
                  controller: desController,
                ),
              )
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          ElevatedButton(
              onPressed: widget.isAdd ? insertFuncion : editFuncion,
              child: Text(widget.isAdd ? "Thêm" : "Chỉnh sửa"))
        ],
      ),
    );
  }
}
