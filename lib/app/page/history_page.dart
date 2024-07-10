import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_homework_8910/app/data/api.dart';
import 'package:flutter_homework_8910/app/data/sharepre.dart';
import 'package:flutter_homework_8910/app/model/history_order.dart';
import 'package:flutter_homework_8910/app/model/user.dart';
import 'package:flutter_homework_8910/widget/item_history_order.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  late Future<List<HistoryOrder>> _futureOrders;
  Future<List<HistoryOrder>> getData() async {
    print("dang vao ham lay data");
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String token = preferences.getString("token")!;
    User user = await getUser();
    List<HistoryOrder> orders =
        await APIRepository().getHistoryOrder(token, user);
    return orders;
  }

  void removeHis(String id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String token = preferences.getString("token")!;
    String result = await APIRepository().removeHistory(id, token);
    print(result);
  }

  @override
  void initState() {
    super.initState();
    getData().then((data) {
      setState(() {
        _futureOrders = getData();
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
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No products found'));
            }
            return Dismissible(
                background: Container(
                  color: Colors.red,
                  child: const Icon(Icons.delete),
                ),
                key: ValueKey<HistoryOrder>(snapshot.data![index]),
                onDismissed: (direction) async {
                  removeHis(snapshot.data![index].id);
                },
                child: ItemHistory(itemHistory: itemHis));
          },
        );
      },
    ));
  }
}
