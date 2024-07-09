import 'package:flutter/material.dart';
import 'package:flutter_homework_8910/app/model/category.dart';

class itemCategory extends StatelessWidget {
  itemCategory({super.key, required this.category});
  Category category;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        width: 90,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.grey[300],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.network(width: 30, height: 30, category.imageURL),
            Text(
              category.name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }
}
