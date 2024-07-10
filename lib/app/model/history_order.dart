class HistoryOrder {
  String id;
  String fullName;
  String dateCreated;
  int total;

  HistoryOrder({
    required this.id,
    required this.fullName,
    required this.dateCreated,
    required this.total,
  });

  factory HistoryOrder.fromJson(Map<String, dynamic> json) => HistoryOrder(
      id: json['id'],
      fullName: json['fullName'],
      dateCreated: json['dateCreated'],
      total: json['total']);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['fullName'] = this.fullName;
    data['dateCreated'] = this.dateCreated;
    data['total'] = this.total;
    return data;
  }
}
