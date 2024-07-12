import 'package:flutter/material.dart';
import 'package:flutter_homework_8910/app/data/helper/db_helper.dart';
import 'package:flutter_homework_8910/app/model/product.dart';
import 'package:flutter_homework_8910/widget/item_shoe_favorite.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  Future<List<Product>> getProductFavorite() async {
    return await _databaseHelper.productsFavorite();
  }

  void onDeleteFavorite(int id) async {
    await _databaseHelper.deleteProduct(id);
    print("da xoa danh sach yeu thich");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorite page"),
      ),
      body: FutureBuilder(
        future: getProductFavorite(),
        builder: (context, snapshot) {
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              var item = snapshot.data![index];
              return ItemShoeFavorite(
                  functionDeleteFavorite: () =>
                      onDeleteFavorite(item.idProduct!),
                  shoe: Product(
                      nameProduct: item.nameProduct,
                      imageUrl: item.imageUrl,
                      price: item.price,
                      idCategory: item.idCategory));
            },
          );
        },
      ),
    );
  }
}
