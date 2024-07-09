import 'package:flutter/material.dart';
import 'package:flutter_homework_8910/app/data/api.dart';
import 'package:flutter_homework_8910/app/data/sharepre.dart';
import 'package:flutter_homework_8910/app/model/product.dart';
import 'package:flutter_homework_8910/app/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProduct extends StatefulWidget {
  EditProduct({super.key, required this.isAdd, this.product});
  bool isAdd;
  Product? product;

  @override
  State<EditProduct> createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  late TextEditingController nameController;
  late TextEditingController disController;

  late TextEditingController imageController;
  late TextEditingController priceController;
  late TextEditingController cateIdController;

  @override
  void initState() {
    super.initState();

    nameController = TextEditingController(
        text: widget.isAdd ? '' : widget.product?.nameProduct ?? '');
    disController = TextEditingController(
        text: widget.isAdd ? '' : widget.product?.description ?? '');
    imageController = TextEditingController(
        text: widget.isAdd ? '' : widget.product?.imageUrl ?? '');
    priceController = TextEditingController(
        text: widget.isAdd ? '' : widget.product?.price.toString() ?? '');
    cateIdController = TextEditingController(
        text: widget.isAdd ? '' : widget.product?.idCategory.toString() ?? '');
  }

  editFuncion() async {
    print("dagn edit product");
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String token = await preferences.getString("token")!;
    User user = await getUser();

    Product pro = Product(
      idProduct: widget.product!.idProduct,
      nameProduct: nameController.text,
      imageUrl: imageController.text,
      price: int.parse(priceController.text),
      idCategory: widget.product!.idCategory,
    );
    String request =
        await APIRepository().updatePro(pro, user.accountId.toString(), token);
    print(request);
    print("Ket thuc edit pro");
    Navigator.pop(context);
  }

  insertFuncion() async {
    print("dang vo insert pro");
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String token = await preferences.getString("token")!;
    User user = await getUser();
    Product model = Product(
        nameProduct: nameController.text,
        imageUrl: imageController.text,
        price: int.parse(priceController.text),
        idCategory: int.parse(cateIdController.text));

    String request = await APIRepository()
        .insertProduct(model, user.accountId.toString(), token);
    print(request);
    print("ket thuc insert");
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            widget.isAdd ? Text("Thêm sản phẩm") : Text("Chỉnh sửa sản phẩm"),
      ),
      body: Column(
        children: [
          Row(
            children: [
              const Text("name: "),
              Expanded(
                child: TextFormField(
                  controller: nameController,
                ),
              )
            ],
          ),
          Row(
            children: [
              const Text("description: "),
              Expanded(
                child: TextFormField(
                  controller: disController,
                ),
              )
            ],
          ),
          Row(
            children: [
              const Text("imageUrl: "),
              Expanded(
                child: TextFormField(
                  controller: imageController,
                ),
              )
            ],
          ),
          Row(
            children: [
              const Text("price: "),
              Expanded(
                child: TextFormField(
                  controller: priceController,
                ),
              )
            ],
          ),
          Row(
            children: [
              const Text("category: "),
              Expanded(
                child: TextFormField(
                  controller: cateIdController,
                ),
              )
            ],
          ),
          ElevatedButton(
              onPressed: widget.isAdd ? insertFuncion : editFuncion,
              child: Text(widget.isAdd ? "Thêm" : "Chỉnh sửa"))
        ],
      ),
    );
  }
}
