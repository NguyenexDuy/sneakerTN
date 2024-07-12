import 'package:flutter/material.dart';
import 'package:flutter_homework_8910/app/model/product.dart';

class ItemShoeFavorite extends StatefulWidget {
  ItemShoeFavorite(
      {super.key, required this.shoe, required this.functionDeleteFavorite});

  Product shoe;
  VoidCallback functionDeleteFavorite;

  @override
  State<ItemShoeFavorite> createState() => _ItemShoeFavoriteState();
}

class _ItemShoeFavoriteState extends State<ItemShoeFavorite> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 50),
            width: 120,
            height: 120,
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
              padding: const EdgeInsets.only(left: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 50,
                        child: Text(
                          widget.shoe.nameProduct,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const Text("3 colors"),
                      Text("${widget.shoe.price.toString()} \$"),
                    ],
                  ),
                  IconButton(
                      onPressed: widget.functionDeleteFavorite,
                      icon: const Icon(
                        Icons.favorite,
                        color: Colors.red,
                      ))
                ],
              ),
            ),
          ),
          Image.network(
            widget.shoe.imageUrl,
            width: 120,
            height: 80,
            fit: BoxFit.cover,
          ),
        ],
      ),
    );
  }
}
