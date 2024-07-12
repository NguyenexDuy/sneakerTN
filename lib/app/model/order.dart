class Order {
  String productID;
  int count;

  Order({
    required this.productID,
    required this.count,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['productID'] = productID;
    data['count'] = count;

    return data;
  }
}
