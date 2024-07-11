class Product {
  int? idProduct;
  String nameProduct;
  String? description;
  String imageUrl;
  int price;
  int idCategory;
  String? categoryName;
  bool? isFavorite;

  Product(
      {this.idProduct,
      required this.nameProduct,
      this.description,
      required this.imageUrl,
      required this.price,
      required this.idCategory,
      this.categoryName,
      this.isFavorite});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        idProduct: json['id'],
        nameProduct: json['name'],
        description: json['description'],
        imageUrl: json['imageURL'],
        price: json['price'],
        idCategory: json['categoryID'],
        categoryName: json['categoryName']);
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
        idProduct: map['id'],
        nameProduct: map['name'],
        description: map['description'],
        imageUrl: map['imageURL'],
        price: map['price'],
        idCategory: map['categoryID'],
        categoryName: map['categoryName'],
        isFavorite: map['isFavorite']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = idProduct;
    data['name'] = nameProduct;
    data['description'] = description;
    data['imageURL'] = imageUrl;
    data['price'] = price;
    data['categoryID'] = idCategory;
    data['categoryName'] = categoryName;
    data['isFavorite'] = isFavorite;
    return data;
  }
}
