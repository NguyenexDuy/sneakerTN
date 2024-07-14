import 'package:flutter/material.dart';
import 'package:flutter_homework_8910/app/data/cart_provider.dart';
import 'package:flutter_homework_8910/app/data/helper/db_helper.dart';
import 'package:flutter_homework_8910/app/model/product.dart';
import 'package:provider/provider.dart';

class ShoeDetailPage extends StatefulWidget {
  ShoeDetailPage({super.key, required this.product});
  Product product;

  @override
  State<ShoeDetailPage> createState() => _ShoeDetailPageState();
}

class _ShoeDetailPageState extends State<ShoeDetailPage> {
  final DatabaseHelper _databaseService = DatabaseHelper();

  bool isFavorite = false;
  List<String> size = ['37', '38', '39', '40', '41', '42'];

  Future<void> onSaveFavorite() async {
    await _databaseService.insertProduct(widget.product);
    print("da luu vao danh sach yeu thich");
    setState(() {
      isFavorite = !isFavorite;
    });
  }

  Future<void> onDeleteFavorite() async {
    await _databaseService.deleteProduct(widget.product.idProduct!);
    print("da xoa danh sach yeu thich");
    setState(() {
      isFavorite = !isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Chi tiết giày"),
          actions: [
            IconButton(
              icon: isFavorite
                  ? const Icon(
                      Icons.favorite,
                      color: Colors.red,
                    )
                  : const Icon(
                      Icons.favorite_border,
                    ),
              onPressed: () {
                isFavorite ? onDeleteFavorite() : onSaveFavorite();
              },
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: 230,
                color: Colors.grey[200],
                child: Center(
                  child: Image.network(
                      width: 200, height: 200, widget.product.imageUrl),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.product.nameProduct,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Text(
                          "${widget.product.price} \$",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        )),
                    const Text(
                      "Thông tin mô tả",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    const Text(
                        "Shoes are an essential part of our daily attire, offering both protection and style. They come in various types, including sneakers, boots, sandals, and formal shoes, each designed for different occasions and purposes. "),
                    const Text(
                      "Size",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 24,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: size.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.grey[400],
                              ),
                              child: Center(child: Text(size[index])),
                            ),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Consumer<CartProvider>(
                        builder: (context, value, child) => ElevatedButton(
                            onPressed: () {
                              value.add(widget.product);

                              const snackbar = SnackBar(
                                  content:
                                      Text("Thêm vào giỏ hàng thành công"));

                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackbar);
                            },
                            child: const Text('Thêm vào giỏ hàng')),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
