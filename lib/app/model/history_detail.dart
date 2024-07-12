class HistoryDetail {
  int productId;
  String productName;
  String imageUrl;
  int price;
  int cout;
  int total;

  HistoryDetail({
    required this.productId,
    required this.productName,
    required this.imageUrl,
    required this.price,
    required this.cout,
    required this.total,
  });
  factory HistoryDetail.fromJson(Map<String, dynamic> json) {
    return HistoryDetail(
        productId: json['productID'],
        productName: json['productName'],
        imageUrl: json['imageURL'],
        price: json['price'],
        cout: json['count'],
        total: json['total']);
  }
}
