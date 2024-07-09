import 'package:flutter/material.dart';
import 'package:flutter_homework_8910/app/data/cart_provider.dart';
import 'package:flutter_homework_8910/app/model/product.dart';
import 'package:provider/provider.dart';

class item_cart extends StatelessWidget {
  item_cart({super.key, required this.product});
  Product product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.grey[100],
            boxShadow: const [
              BoxShadow(
                  color: Colors.grey,
                  spreadRadius: 2,
                  blurRadius: 8,
                  offset: Offset(3, 5))
            ]),
        width: double.infinity,
        height: 130,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.network(width: 100, height: 100, product.imageUrl),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 150,
                      child: Text(
                        product.nameProduct,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    Text(
                      "${product.price} \$",
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
            Consumer<CartProvider>(
              builder: (context, value, child) {
                return IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    value.del(value.list.indexOf(product));
                  },
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
