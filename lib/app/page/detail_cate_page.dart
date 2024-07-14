import 'package:flutter/material.dart';
import 'package:flutter_homework_8910/app/data/api.dart';
import 'package:flutter_homework_8910/app/data/sharepre.dart';
import 'package:flutter_homework_8910/app/model/category.dart';
import 'package:flutter_homework_8910/app/model/product.dart';
import 'package:flutter_homework_8910/app/model/user.dart';
import 'package:flutter_homework_8910/widget/item_shoeOf_brand.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailCatePage extends StatefulWidget {
  DetailCatePage({super.key, required this.category});
  Category category;

  @override
  State<DetailCatePage> createState() => _DetailCatePageState();
}

class _DetailCatePageState extends State<DetailCatePage> {
  late Future<List<Product>> _listProduct;

  Future<List<Product>> getListProduct() async {
    print("dang vo payment");
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String token = preferences.getString("token")!;
    User user = await getUser();
    List<Product> product = [];
    product = await APIRepository().getProductByIdCategory(
        widget.category.idCategory.toString(),
        token,
        user.accountId.toString());

    return product;
  }

  @override
  void initState() {
    super.initState();
    _listProduct = getListProduct();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category.name),
      ),
      body: FutureBuilder(
        future: getListProduct(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No products found'));
          }
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              var itemBuild = snapshot.data![index];
              return ItemShoeOfBrand(shoe: itemBuild);
            },
          );
        },
      ),
    );
  }
}
