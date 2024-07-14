import 'package:flutter/material.dart';
import 'package:flutter_homework_8910/app/model/product.dart';

class ItemShoeOfBrand extends StatefulWidget {
  ItemShoeOfBrand({
    super.key,
    required this.shoe,
  });

  Product shoe;

  @override
  State<ItemShoeOfBrand> createState() => _ItemShoeOfBrandState();
}

class _ItemShoeOfBrandState extends State<ItemShoeOfBrand> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 50),
            width: 140,
            height: 140,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black38,
                      spreadRadius: 0,
                      blurRadius: 4,
                      offset: Offset(0, 4))
                ]),
            child: Padding(
              padding: const EdgeInsets.only(left: 10, top: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.shoe.nameProduct,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Text("3 colors"),
                  Text("${widget.shoe.price.toString()} \$"),
                ],
              ),
            ),
          ),
          Image.network(
            widget.shoe.imageUrl,
            width: 140,
            height: 80,
            fit: BoxFit.cover,
          ),
        ],
      ),
    );
  }
}
