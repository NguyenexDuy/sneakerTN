class Product {
  int? idProduct;
  String nameProduct;
  String? description;
  String imageUrl;
  int price;
  int idCategory;
  String? categoryName;

  Product(
      {this.idProduct,
      required this.nameProduct,
      this.description,
      required this.imageUrl,
      required this.price,
      required this.idCategory,
      this.categoryName});

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

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['productID'] = this.idProduct;

  // }
}
