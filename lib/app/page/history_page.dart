import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_homework_8910/app/data/api.dart';
import 'package:flutter_homework_8910/app/data/sharepre.dart';
import 'package:flutter_homework_8910/app/model/history_order.dart';
import 'package:flutter_homework_8910/app/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  List<HistoryOrder> orders = [];
  Future<List<HistoryOrder>> getData() async {
    print("dang vao ham lay data");

    SharedPreferences preferences = await SharedPreferences.getInstance();
    String token = await preferences.getString("token")!;
    User user = await getUser();
    orders = await APIRepository().getHistoryOrder(token, user);

    return orders;
  }

  void RemoveHis(String id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String token = await preferences.getString("token")!;
    User user = await getUser();
    String result = await APIRepository().removeHistory(id, token);
    print(result);
  }

  @override
  void initState() {
    super.initState();
    getData().then((data) {
      setState(() {
        orders = data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
      future: getData(),
      builder: (context, snapshot) {
        return ListView.builder(
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) {
            final itemHis = snapshot.data![index];
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Dismissible(
                background: Container(
                  color: Colors.red,
                  child: const Icon(Icons.delete),
                ),
                key: ValueKey<HistoryOrder>(snapshot.data![index]),
                onDismissed: (direction) async {
                  // setState(() {
                  //   snapshot.data!.removeAt(index);
                  //   RemoveHis(snapshot.data![index].id);
                  // });
                  RemoveHis(snapshot.data![index].id);
                },
                child: item_history(itemHistory: itemHis));
          },
        );
      },
    ));
  }
}

class item_history extends StatelessWidget {
  item_history({super.key, required this.itemHistory});
  HistoryOrder itemHistory;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
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
                    SizedBox(
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
