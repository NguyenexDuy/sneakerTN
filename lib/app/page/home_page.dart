import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_homework_8910/app/data/api.dart';
import 'package:flutter_homework_8910/app/model/category.dart';
import 'package:flutter_homework_8910/app/model/product.dart';
import 'package:flutter_homework_8910/app/model/user.dart';
import 'package:flutter_homework_8910/app/page/shoe_detail_page.dart';
import 'package:flutter_homework_8910/widget/item_category.dart';
import 'package:flutter_homework_8910/widget/item_shoeOf_brand.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentSlide = 0;
  User user = User.userEmpty();
  bool isSelected = false;
  List<Category> categories = [];
  List<Product> products = [];
  List<String> imageUrls = [
    "assets/images/banner/banner01.jpg",
    "assets/images/banner/banner02.jpg",
    "assets/images/banner/banner03.jpg",
    "assets/images/banner/banner04.jpg",
    "assets/images/banner/banner05.jpg",
  ];
  getData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String strUser = pref.getString('user')!;

    user = User.fromJson(jsonDecode(strUser));

    String token = pref.getString("token")!;
    List<Product> listPro =
        await APIRepository().getProduct(user.accountId.toString(), token);

    setState(() {
      products = listPro;
    });

    List<Category> listCate =
        await APIRepository().getCates(user.accountId.toString(), token);
    log("day la chie dai cua listCate: ${listCate.length}");
    setState(() {
      categories = listCate;
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Stack(children: [
              SizedBox(
                height: 150,
                width: double.infinity,
                child: PageView.builder(
                  onPageChanged: (value) {
                    setState(() {
                      currentSlide = value;
                    });
                  },
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Container(
                      width: double.infinity,
                      height: 150,
                      decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(12),
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: AssetImage(imageUrls[index]))),
                    );
                  },
                ),
              ),
              Positioned.fill(
                  bottom: 10,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                            5,
                            (index) => AnimatedContainer(
                                  duration: const Duration(milliseconds: 300),
                                  width: currentSlide == index ? 15 : 8,
                                  height: 8,
                                  margin: const EdgeInsets.only(right: 3),
                                  decoration: BoxDecoration(
                                    color: currentSlide == index
                                        ? Colors.white
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: Colors.white),
                                  ),
                                ))),
                  ))
            ]),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: SizedBox(
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  var itemCate = categories[index];
                  return itemCategory(
                    category: itemCate,
                  );
                },
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(12),
            child: Row(
              children: [
                Text(
                  "Tất cả sản phẩm",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                Text("🔥")
              ],
            ),
          ),
          Expanded(
            child: GridView.builder(
              itemCount: products.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemBuilder: (context, index) {
                var itemIndex = products[index];
                return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ShoeDetailPage(
                            product: itemIndex,
                          ),
                        ));
                  },
                  child: ItemShoeOfBrand(shoe: itemIndex),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
