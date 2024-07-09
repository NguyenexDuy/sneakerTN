class Order {
  String productID;
  int count;

  Order({
    required this.productID,
    required this.count,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['productID'] = this.productID;
    data['count'] = this.count;

    return data;
  }
}
