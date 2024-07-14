import 'package:flutter/material.dart';
import 'package:flutter_homework_8910/app/model/product.dart';

class CartProvider extends ChangeNotifier {
  List<Product> list = [];

  add(Product mo) {
    list.add(mo);
    notifyListeners();
  }

  del(int index) {
    list.removeAt(index);
    notifyListeners();
  }

  deleteAll() {
    list = [];
  }

  int get sum {
    int count = 0;

    if (list.isNotEmpty) {
      for (var element in list) {
        count += element.price;
      }
      return count;
    }

    notifyListeners();
    return count;
  }
}
