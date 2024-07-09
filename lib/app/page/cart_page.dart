import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_homework_8910/app/data/api.dart';
import 'package:flutter_homework_8910/app/data/cart_provider.dart';
import 'package:flutter_homework_8910/app/data/sharepre.dart';
import 'package:flutter_homework_8910/app/model/order.dart';
import 'package:flutter_homework_8910/app/model/product.dart';
import 'package:flutter_homework_8910/app/model/user.dart';
import 'package:flutter_homework_8910/widget/item_cart.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<Order> orders = [];

  getListOrder(List<Product> pro) {
    for (var element in pro) {
      orders.add(Order(productID: element.idProduct.toString(), count: 1));
    }
  }

  payMentMethod() async {
    print("dang vo payment");
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String token = await preferences.getString("token")!;
    User user = await getUser();
    String request = await APIRepository().paymentCart(orders, token);
    print(request);
    print("ket thuc payment");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<CartProvider>(
        builder: (context, value, child) {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: value.list.length,
                  itemBuilder: (context, index) {
                    var itemPro = value.list[index];
                    return item_cart(
                      product: itemPro,
                    );
                  },
                ),
              ),
              Container(
                height: 150,
                width: double.infinity,
                color: Colors.grey[350],
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Tổng tiền",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 25),
                        ),
                        Text(
                          value.sum.toString(),
                          style: const TextStyle(fontSize: 18),
                        )
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // for (var element in value.list) {
                        //   orders.add(Order(
                        //       productID: element.idProduct.toString(),
                        //       count: 1));
                        // }
                        getListOrder(value.list);

                        print("Ressult ${orders.length}");
                        payMentMethod();
                      },
                      child: const Text("Thanh toán"),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
