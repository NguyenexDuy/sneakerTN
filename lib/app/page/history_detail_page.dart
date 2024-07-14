import 'package:flutter/material.dart';
import 'package:flutter_homework_8910/app/data/api.dart';
import 'package:flutter_homework_8910/app/model/history_detail.dart';
import 'package:flutter_homework_8910/app/model/history_order.dart';
import 'package:flutter_homework_8910/widget/item_history_detail.dart';
import 'package:flutter_homework_8910/widget/tinh_trang_don_hang.dart';
import 'package:order_tracker/order_tracker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryDetailPage extends StatefulWidget {
  HistoryDetailPage({super.key, required this.historyOrder});
  HistoryOrder historyOrder;

  @override
  State<HistoryDetailPage> createState() => _HistoryDetailPageState();
}

class _HistoryDetailPageState extends State<HistoryDetailPage> {
  Future<List<HistoryDetail>> getItemHistoryDetail() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String token = preferences.getString("token")!;
    List<HistoryDetail> his = [];
    his = await APIRepository()
        .getHistoryDetailById(widget.historyOrder.id, token);
    return his;
  }

  List<TextDto> orderList = [
    TextDto("Your order has been placed", "Fri, 25th Mar '22 - 10:47pm"),
    TextDto("Seller ha processed your order", "Sun, 27th Mar '22 - 10:19am"),
    TextDto("Your item has been picked up by courier partner.",
        "Tue, 29th Mar '22 - 5:00pm"),
  ];

  List<TextDto> shippedList = [
    TextDto("Your order has been shipped", "Tue, 29th Mar '22 - 5:04pm"),
    TextDto("Your item has been received in the nearest hub to you.", null),
  ];

  List<TextDto> outOfDeliveryList = [
    TextDto("Your order is out for delivery", "Thu, 31th Mar '22 - 2:27pm"),
  ];

  List<TextDto> deliveredList = [
    TextDto("Your order has been delivered", "Thu, 31th Mar '22 - 3:58pm"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chi tiết hóa đơn"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const tinhtrangdonhang(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Mã đơn hàng:${widget.historyOrder.id}"),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    child: Text(
                      "Theo dõi đơn hàng",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  // sử dụng pubget track order
                  SizedBox(
                    width: double.infinity,
                    child: OrderTracker(
                      status: Status.delivered,
                      activeColor: Colors.green,
                      inActiveColor: Colors.grey[300],
                      orderTitleAndDateList: orderList,
                      shippedTitleAndDateList: shippedList,
                      outOfDeliveryTitleAndDateList: outOfDeliveryList,
                      deliveredTitleAndDateList: deliveredList,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    child: Text('Danh mục sản phẩm'),
                  ),
                  Container(
                    width: double.infinity,
                    height: 200,
                    color: Colors.grey[200],
                    child: FutureBuilder(
                      future: getItemHistoryDetail(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (snapshot.hasError) {
                          return Center(
                              child: Text('Error: ${snapshot.error}'));
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          return const Center(child: Text('No products found'));
                        }
                        return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return itemHistoryDetail(
                              historyDetail: snapshot.data![index],
                            );
                          },
                        );
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Thành tiền",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text("${widget.historyOrder.total.toString()} \$"),
                    ],
                  ),
                  const Text("Phương thức thanh toán: "),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 20),
                    child: Text(
                      "Visa",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
