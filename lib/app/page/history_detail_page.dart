import 'package:flutter/material.dart';
import 'package:flutter_homework_8910/app/data/api.dart';
import 'package:flutter_homework_8910/app/model/history_detail.dart';
import 'package:flutter_homework_8910/app/model/history_order.dart';
import 'package:flutter_homework_8910/widget/item_history_detail.dart';
import 'package:flutter_homework_8910/widget/tinh_trang_don_hang.dart';
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
            Text("Mã đơn hàng: oeirweo2343"),
            const Text(
              "Theo dõi đơn hàng",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),

            // sử dụng pubget track order
            Container(
              width: double.infinity,
              height: 400,
              color: Colors.red,
            ),
            const Text('Danh mục sản phẩm'),
            Container(
              width: double.infinity,
              height: 200,
              color: Colors.grey[200],
              child: FutureBuilder(
                future: getItemHistoryDetail(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
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
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Thành tiền"),
                Text("385.000 VND"),
              ],
            ),
            const Text("Phương thức thanh toán: "),
          ],
        ),
      ),
    );
  }
}
