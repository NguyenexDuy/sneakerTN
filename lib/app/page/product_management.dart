import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_homework_8910/app/data/api.dart';
import 'package:flutter_homework_8910/app/model/product.dart';
import 'package:flutter_homework_8910/app/model/user.dart';
import 'package:flutter_homework_8910/app/page/edit_product.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductManagement extends StatefulWidget {
  const ProductManagement({super.key});

  @override
  State<ProductManagement> createState() => _ProductManagementState();
}

class _ProductManagementState extends State<ProductManagement> {
  User user = User.userEmpty();

  Future<List<Product>> getAllProdcut() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String strUser = pref.getString('user')!;
    String token = pref.getString("token")!;

    user = User.fromJson(jsonDecode(strUser));

    setState(() {});

    List<Product> listCate =
        await APIRepository().getProduct("21dh110294", token);
    print("day la chie dai cua listCate: ${listCate.length}");

    return listCate;
  }

  Future<List<Product>>? future;
  @override
  void initState() {
    future = getAllProdcut();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isAdd = true;

    return Scaffold(
      appBar: AppBar(
        title: Text("Quản lý sản phẩm"),
      ),
      body: FutureBuilder(
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
              var itemProduct = snapshot.data![index];

              return Padding(
                padding: EdgeInsets.all(12),
                child: Container(
                  width: double.infinity,
                  height: 150,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.red[200]),
                  child: Row(
                    children: [
                      Image.network(
                          width: 100, height: 100, itemProduct.imageUrl),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    itemProduct.nameProduct,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                            Text(itemProduct.description ??
                                "khong co description"),
                            Text(itemProduct.price.toString()),
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
                                  });
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => EditProduct(
                                          isAdd: isAdd,
                                          product: itemProduct,
                                        ),
                                      ));
                                }
                              }),
                          IconButton(
                              onPressed: () {}, icon: const Icon(Icons.delete))
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (isAdd) {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditProduct(isAdd: isAdd),
                ));
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
