import 'package:flutter/material.dart';
import 'package:flutter_homework_8910/app/model/history_order.dart';
import 'package:flutter_homework_8910/app/page/history_detail_page.dart';

class ItemHistory extends StatelessWidget {
  ItemHistory({super.key, required this.itemHistory});
  HistoryOrder itemHistory;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HistoryDetailPage(
                historyOrder: itemHistory,
              ),
            ));
      },
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(color: Colors.grey[300]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  padding: const EdgeInsets.all(8),
                  color: Colors.grey[350],
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 200,
                            child: Text(
                              "Mã đơn: ${itemHistory.id}",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const Icon(Icons.local_shipping),
                        ],
                      ),
                      const Icon(Icons.chevron_right_rounded)
                    ],
                  )),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  "Đơn hàng của bạn đang được xử lý",
                  style: TextStyle(fontSize: 10),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(
                      height: 70,
                      width: 70,
                      child: Icon(
                        Icons.redeem,
                        size: 45,
                      ),
                    ),
                    Row(
                      children: [
                        const Icon(Icons.paid_outlined),
                        Text("Thành tiền: ${itemHistory.total}")
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
